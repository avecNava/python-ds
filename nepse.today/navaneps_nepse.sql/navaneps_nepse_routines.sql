
DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `sp_52_wks_high_low`$$
$$

DROP PROCEDURE IF EXISTS `sp_getCommissionDetail`$$
$$

DROP PROCEDURE IF EXISTS `sp_getCompanies`$$
$$

DROP PROCEDURE IF EXISTS `sp_getLTP`$$
$$

DROP PROCEDURE IF EXISTS `sp_getShareholder`$$
$$

DROP PROCEDURE IF EXISTS `sp_getStockMetadata`$$
$$

DROP PROCEDURE IF EXISTS `sp_GetUsers`$$
$$

DROP PROCEDURE IF EXISTS `sp_investment_gains`$$
CREATE DEFINER=`navanepse`@`localhost` PROCEDURE `sp_investment_gains` (`login_id` INT)  BEGIN
-- NAVA BOGATEE
-- MODIFIED 12MAR2018
-- FIXED CALCULATIONS ET GLITCHES
-- CALCULATE OVERALL GAIN, DAY GAIN, INVESTMENT,
-- ADDED NEW TABLE FOR SCRIPT TRANS DATE (NEPSE_TRADEDATE) AND NEW LOGIC FOR LAST_TRANS_DATE CALC
SELECT 
-- DATE_FORMAT(d.trans_date,'%Y-%m-%d') AS `trans_date`,
-- p.symbol, 
@total_quantity := SUM(p.Quantity) AS 'total_shares',
@investment := SUM(p.Quantity * p.Effective_rate) AS 'investment',
@broker_commission := SUM(fnGetCommission(p.Quantity*d.LTP,p.stock_type_id,'SELL','AMT')) AS 'broker_comm',
@total_worth := SUM(fn_total_worth_per_stock(p.portfolio_id,d.trans_date)) AS 'total_worth',
@overall_gain := CAST(@total_worth - @investment AS DECIMAL(15,2)) AS 'overall_gain',
@day_gain := SUM(p.Quantity *(d.LTP - d.Prev_closing)) AS 'day_gain',
@trade_date := d.trans_date AS 'trade_date'
FROM nepse_portfolio p
LEFT JOIN nepse_data d ON p.symbol=d.symbol 
AND d.trans_date>=fn_last_transaction_date(p.symbol)
WHERE p.login_id = login_id
AND d.trans_date IS NOT NULL;
-- AND p.symbol='ADBL'
-- GROUP BY p.symbol

	
	END$$

DROP PROCEDURE IF EXISTS `sp_portfolio_detail`$$
CREATE DEFINER=`navanepse`@`localhost` PROCEDURE `sp_portfolio_detail` (`_symbol` VARCHAR(10), `_login_id` INT)  BEGIN	
SELECT 
p.Portfolio_id,
p.transaction_no,
p.symbol,
fn_get_company_name(p.Symbol) AS company_name,
p.Quantity AS 'quantity' ,
p.Effective_rate AS 'effective_rate' ,
d.LTP AS 'ltp', 
(d.LTP - d.Prev_closing) AS 'change',
(p.Quantity*(d.LTP - d.Prev_closing))  AS 'day_gain',
@investment := CAST(p.Quantity * p.Effective_rate AS DECIMAL(10,2)) AS 'investment',
@total_worth := CAST(p.Quantity * d.LTP AS DECIMAL(10,2) ) AS 'total_worth',
(p.Quantity * (d.LTP - p.Effective_rate))  AS 'overall_gain',
@commission_amount := fnGetCommission(p.Quantity*d.LTP,p.stock_type_id,'SELL','AMT') AS 'broker_comm',
@sebon_fee := fn_sebon_fee(@total_worth) AS 'sebon_fee',
@dp_amount := fn_dp_amount() AS 'dp_amount',
fn_capital_gain_tax(@investment, @total_worth) AS 'capital_gain_tax',
@net_amount := (fn_worth_per_portfolio(p.portfolio_id))  AS 'net_worth',
CAST(@net_amount - @investment AS DECIMAL(10,2)) AS 'profit',
p.offr_code,
p.Remarks AS 'remarks',
g.GroupName AS 'share_group_name',
o.Offr_title AS 'acquire_method',
-- DATE_FORMAT(p.Purchase_date, '%Y/%m/%d') as 'purchase_date',
p.Purchase_date AS 'purchase_date',
DATEDIFF(CURDATE(),p.Purchase_date) AS 'no_days',
p.login_id, 
s.shareholder_name,
DATE_FORMAT(d.trans_date,'%Y/%m/%d') AS 'trade_date',
CASE DATEDIFF(CURDATE(),d.trans_date)
WHEN 0 THEN 1 ELSE 0 END AS 'latest'
FROM nepse_portfolio p
LEFT JOIN nepse_data d ON p.symbol = d.symbol 
INNER JOIN nepse_share_group g ON p.GroupID = g.GroupID
INNER JOIN nepse_share_offering o ON p.offr_code = o.offr_code
INNER JOIN nepse_shareholder s ON p.login_id = s.login_id AND p.shareholder_id = s.shareholder_id
AND d.trans_date >= fn_last_transaction_date(_symbol)
WHERE p.symbol= _symbol AND s.login_id= _login_id;
END$$

DROP PROCEDURE IF EXISTS `sp_portfolio_summary`$$
CREATE DEFINER=`navanepse`@`localhost` PROCEDURE `sp_portfolio_summary` (`_login_id` INT)  BEGIN

-- NAVA RAJ BOGATEE
-- 12 MAR 2017
-- MODIFIED TO MATCH THE SP_INVESTMENT_GAINS
SELECT 
p.symbol,
fn_get_company_name(p.Symbol) AS company_name,
SUM(p.Quantity) AS quantity, 
CAST(SUM(p.Quantity * p.effective_rate) / SUM(p.Quantity) AS DECIMAL(6,2)) AS `eff_cost_price`,
DATE_FORMAT(d.trans_date,'%Y-%m-%d') AS `trans_date`,
d.LTP AS `ltp`, 
@change := d.LTP - d.Prev_closing AS `change`,
SUM(p.Quantity) * (d.LTP - d.Prev_closing)  AS day_gain,
@investment := SUM(p.Quantity * p.Effective_rate) AS 'investment',
@cost_price := SUM(p.Quantity * d.LTP) AS 'gross_worth',
SUM(p.Quantity * (d.LTP - p.Effective_rate))  AS overall_gain,
@commission_amount := SUM(fnGetCommission(p.Quantity*d.LTP,p.stock_type_id,'SELL','AMT')) AS 'broker_comm',
@net_amount := (fn_worth_per_stock_group(p.symbol,p.stock_type_id,p.login_id,d.trans_date))  AS 'net_worth',
CAST(@net_amount - @investment AS DECIMAL(10,2)) AS 'profit',
fn_52wks_high_low(p.symbol,52) AS `weeks52`,
fn_52wks_high_low(p.symbol,4) AS `weeks04`,
p.offr_code
FROM nepse_portfolio p
INNER JOIN nepse_shareholder s ON p.login_id = s.login_id AND p.shareholder_id = s.shareholder_id
LEFT JOIN nepse_data d ON p.symbol=d.symbol 
AND d.trans_date>=fn_last_transaction_date(p.symbol)
WHERE p.login_id = _login_id
GROUP BY p.symbol;

	END$$

--
-- Functions
--
DROP FUNCTION IF EXISTS `fnGetCommission`$$
$$

DROP FUNCTION IF EXISTS `fnGetTotalShares`$$
$$

DROP FUNCTION IF EXISTS `fnLastTransactionDate`$$
CREATE DEFINER=`navanepse`@`localhost` FUNCTION `fnLastTransactionDate` () RETURNS DATE BEGIN

	DECLARE last_trans_date DATETIME;
	
	SELECT DATE_FORMAT(MAX(transaction_date),'%Y-%m-%d') INTO last_trans_date FROM nepse_metadata;
	
	RETURN last_trans_date;
	

    END$$

DROP FUNCTION IF EXISTS `fn_52wks_high_low`$$
CREATE DEFINER=`navanepse`@`localhost` FUNCTION `fn_52wks_high_low` (`_symbol` VARCHAR(10), `weeks` INT) RETURNS VARCHAR(50) CHARSET latin1 NO SQL
    DETERMINISTIC
BEGIN

SELECT 
ROUND(MIN(ltp),2), ROUND(MAX(ltp),2) INTO @low, @high FROM nepse_data 
WHERE symbol= _symbol
AND (FLOOR(DATEDIFF(CURDATE(), trans_date)/7) <= weeks ) ;
RETURN CONCAT(@high, ' - ', @low);

END$$

DROP FUNCTION IF EXISTS `fn_capital_gain_tax`$$
$$

DROP FUNCTION IF EXISTS `fn_dp_amount`$$
$$

DROP FUNCTION IF EXISTS `fn_get_company_name`$$
CREATE DEFINER=`navanepse`@`localhost` FUNCTION `fn_get_company_name` (`_symbol` VARCHAR(10)) RETURNS VARCHAR(50) CHARSET latin1 BEGIN
	
SELECT IFNULL ((SELECT Company END FROM nepse_company WHERE Symbol=_symbol LIMIT 1),_symbol) INTO @company_name;
	RETURN @company_name;
	
END$$

DROP FUNCTION IF EXISTS `fn_last_transaction_date`$$
CREATE DEFINER=`navanepse`@`localhost` FUNCTION `fn_last_transaction_date` (`_symbol` VARCHAR(10)) RETURNS DATE BEGIN

	DECLARE last_trans_date DATETIME;
	
	IF(_symbol ='ALL') THEN
	SELECT DATE_FORMAT(MAX(transaction_date),'%Y-%m-%d') INTO last_trans_date FROM nepse_metadata;
	ELSE
	 SELECT DATE_FORMAT(MAX(trans_date),'%Y-%m-%d') INTO last_trans_date FROM nepse_tradedate WHERE symbol = _symbol;
	-- SELECT DATE_FORMAT(MAX(transaction_date),'%Y-%m-%d') INTO last_trans_date FROM nepse_metadata;
	END IF;
	
	RETURN last_trans_date;
	

    END$$

DROP FUNCTION IF EXISTS `fn_sebon_fee`$$
$$

DROP FUNCTION IF EXISTS `fn_total_worth_per_stock`$$
CREATE DEFINER=`navanepse`@`localhost` FUNCTION `fn_total_worth_per_stock` (`portfolio_id` INT, `trans_date` DATE) RETURNS DOUBLE(15,2) BEGIN

SELECT 
SUM(p.Quantity*p.Effective_rate),
SUM(p.Quantity*d.LTP),
SUM(fnGetCommission(p.Quantity*d.LTP,p.stock_type_id,'SELL','AMT'))
INTO
@investment,
@sell_price,
@commission_amount
FROM nepse_portfolio p
INNER JOIN nepse_data d ON p.symbol=d.symbol 
WHERE p.portfolio_id = portfolio_id
AND DATE_FORMAT(d.trans_date,'%Y-%m-%d')=DATE_FORMAT(trans_date,'%Y-%m-%d');


SET @net_amount = @sell_price - (@commission_amount + fn_sebon_fee(@sell_price) + fn_dp_amount()+ fn_capital_gain_tax(@investment,@sell_price));
RETURN @net_amount;

    END$$

DROP FUNCTION IF EXISTS `fn_worth_per_portfolio`$$
CREATE DEFINER=`navanepse`@`localhost` FUNCTION `fn_worth_per_portfolio` (`porfolio_id` INT) RETURNS DOUBLE(10,2) BEGIN	

SELECT 
p.Quantity*p.Effective_rate,
p.Quantity*d.LTP,
fnGetCommission(p.Quantity*d.LTP,p.stock_type_id,'SELL','AMT')
INTO
@buy_price,
@sell_price,
@commission_amount
FROM nepse_portfolio p
INNER JOIN nepse_data d ON p.symbol=d.symbol AND d.flag_new=1
WHERE p.portfolio_id = porfolio_id ;

-- set @net_amount := fn_net_amount(@sell_price, @commission_amount, @sebon_fee, @dp_charge);
SET @net_amount = @sell_price - (@commission_amount + fn_sebon_fee(@sell_price) + fn_dp_amount() + fn_capital_gain_tax(@buy_price,@sell_price));

RETURN @net_amount;

    END$$

DROP FUNCTION IF EXISTS `fn_worth_per_stock_group`$$
CREATE DEFINER=`navanepse`@`localhost` FUNCTION `fn_worth_per_stock_group` (`symbol` VARCHAR(10), `stock_type_id` INT, `login_id` INT, `trans_date` DATE) RETURNS DOUBLE(10,2) BEGIN

SELECT 
SUM(p.Quantity*p.Effective_rate),
SUM(p.Quantity*d.LTP),
SUM(fnGetCommission(p.Quantity*d.LTP,p.stock_type_id,'SELL','AMT'))
INTO
@investment,
@sell_price,
@commission_amount
FROM nepse_portfolio p
INNER JOIN nepse_data d ON p.symbol=d.symbol AND DATE_FORMAT(d.trans_date,'%Y-%m-%d')=DATE_FORMAT(trans_date,'%Y-%m-%d')
WHERE p.symbol=symbol AND p.login_id = login_id
GROUP BY p.symbol;


SET @net_amount = @sell_price - (@commission_amount + fn_sebon_fee(@sell_price) + fn_dp_amount()+ fn_capital_gain_tax(@investment,@sell_price));
RETURN @net_amount;

    END$$

DROP FUNCTION IF EXISTS `getWeightedSum`$$
$$

DELIMITER ;
