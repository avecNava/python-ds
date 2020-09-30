
-- --------------------------------------------------------

--
-- Table structure for table `nepse_stock_type`
--

DROP TABLE IF EXISTS `nepse_stock_type`;
CREATE TABLE `nepse_stock_type` (
  `stock_type_id` int(1) NOT NULL,
  `stock_type` varchar(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `nepse_stock_type`
--

INSERT INTO `nepse_stock_type` (`stock_type_id`, `stock_type`) VALUES
(1, 'Shares'),
(4, 'Bonds'),
(5, 'Debentures'),
(6, 'Mutual Fund');
