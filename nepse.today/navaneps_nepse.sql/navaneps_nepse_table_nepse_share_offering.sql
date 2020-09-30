
-- --------------------------------------------------------

--
-- Table structure for table `nepse_share_offering`
--

DROP TABLE IF EXISTS `nepse_share_offering`;
CREATE TABLE `nepse_share_offering` (
  `offr_code` varchar(10) NOT NULL,
  `offr_title` varchar(50) NOT NULL,
  `commissionable` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `nepse_share_offering`
--

INSERT INTO `nepse_share_offering` (`offr_code`, `offr_title`, `commissionable`) VALUES
('AUCTION', 'Auction', 0),
('DIVIDEND', 'Bonus Share', 0),
('FPO', 'First Public Offering', 0),
('IPO', 'Initial Public Offering', 0),
('RIGHTS', 'Rights Share', 1),
('SCD_MARKET', 'Secondary Market', 1);
