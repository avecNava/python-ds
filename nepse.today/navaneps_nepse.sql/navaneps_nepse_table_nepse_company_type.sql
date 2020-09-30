
-- --------------------------------------------------------

--
-- Table structure for table `nepse_company_type`
--

DROP TABLE IF EXISTS `nepse_company_type`;
CREATE TABLE `nepse_company_type` (
  `type_id` int(5) NOT NULL,
  `type_name` varchar(25) NOT NULL,
  `status` bit(1) NOT NULL DEFAULT b'1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `nepse_company_type`
--

INSERT INTO `nepse_company_type` (`type_id`, `type_name`, `status`) VALUES
(1, 'Hotels', b'1'),
(2, 'Banking', b'1'),
(3, 'Insurance', b'1'),
(4, 'Hydropower', b'1'),
(5, 'Microfinance', b'1'),
(6, 'Finance', b'1'),
(7, 'Mutual Fund', b'1'),
(8, 'Others', b'1'),
(9, 'Production', b'1');
