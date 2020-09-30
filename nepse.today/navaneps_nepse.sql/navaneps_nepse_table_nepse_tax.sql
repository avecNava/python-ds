
-- --------------------------------------------------------

--
-- Table structure for table `nepse_tax`
--

DROP TABLE IF EXISTS `nepse_tax`;
CREATE TABLE `nepse_tax` (
  `action` varchar(4) NOT NULL,
  `stock_type_id` int(11) NOT NULL,
  `offr_code` varchar(10) NOT NULL,
  `low_range` float(12,2) NOT NULL,
  `high_range` float(12,2) NOT NULL,
  `tax_per` float(4,2) NOT NULL,
  `last_update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tax_id` varchar(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `nepse_tax`
--

INSERT INTO `nepse_tax` (`action`, `stock_type_id`, `offr_code`, `low_range`, `high_range`, `tax_per`, `last_update_date`, `tax_id`) VALUES
('acti', 0, 'offr_code', 0.00, 0.00, 0.00, '0000-00-00 00:00:00', 'tax_id'),
('SELL', 0, 'SCD_MARKET', 50001.00, 500000.00, 0.55, '0000-00-00 00:00:00', 'TAX57884801'),
('SELL', 0, 'SCD_MARKET', 500001.00, 20000000.00, 0.50, '0000-00-00 00:00:00', 'TAX57884802'),
('SELL', 0, 'SCD_MARKET', 20000000.00, 10000000.00, 0.45, '0000-00-00 00:00:00', 'TAX57884803'),
('SELL', 0, 'SCD_MARKET', 5000001.00, 1000000000.00, 0.40, '0000-00-00 00:00:00', 'TAX57884804'),
('SELL', 0, 'SCD_MARKET', 0.00, 50000.00, 0.60, '0000-00-00 00:00:00', 'TAX57884805'),
('BUY', 1, 'SCD_MARKET', 0.00, 50000.00, 0.60, '0000-00-00 00:00:00', 'TAX578884a4e4335'),
('BUY', 1, 'SCD_MARKET', 50001.00, 500000.00, 0.55, '0000-00-00 00:00:00', 'TAX57888564c5307'),
('BUY', 1, 'SCD_MARKET', 500001.00, 2000000.00, 0.50, '0000-00-00 00:00:00', 'TAX578a2169ce98e'),
('BUY', 4, 'SCD_MARKET', 0.00, 500000.00, 0.30, '0000-00-00 00:00:00', 'TAX578a2190f265d'),
('BUY', 4, 'SCD_MARKET', 500001.00, 5000000.00, 0.25, '0000-00-00 00:00:00', 'TAX578a2221dfab7'),
('BUY', 4, 'SCD_MARKET', 5000001.00, 10000000000.00, 0.20, '0000-00-00 00:00:00', 'TAX578a22643f103'),
('BUY', 1, 'SCD_MARKET', 10000001.00, 10000000000.00, 0.40, '0000-00-00 00:00:00', 'TAX57a329a074a78'),
('BUY', 1, 'SCD_MARKET', 2000001.00, 10000000.00, 0.45, '0000-00-00 00:00:00', 'TAX58281c0402f04');
