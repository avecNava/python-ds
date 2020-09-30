
-- --------------------------------------------------------

--
-- Table structure for table `nepse_feedback`
--

DROP TABLE IF EXISTS `nepse_feedback`;
CREATE TABLE `nepse_feedback` (
  `feedback_id` int(11) NOT NULL,
  `feedback` varchar(10000) CHARACTER SET utf32 COLLATE utf32_unicode_520_ci NOT NULL,
  `login_id` int(11) NOT NULL,
  `feedback_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_active` bit(1) NOT NULL DEFAULT b'1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `nepse_feedback`
--

INSERT INTO `nepse_feedback` (`feedback_id`, `feedback`, `login_id`, `feedback_datetime`, `is_active`) VALUES
(1, 'Hello charts', 1, '2017-07-22 00:40:59', b'1'),
(2, 'Hello charts', 1, '2017-07-22 00:41:06', b'1'),
(3, 'Hello charts', 1, '2017-07-22 00:41:07', b'1'),
(4, 'Hello charts', 1, '2017-07-22 00:41:08', b'1'),
(5, 'Hello charts', 1, '2017-07-22 00:41:09', b'1'),
(6, 'Hello chart ', 1, '2017-07-22 00:41:14', b'1'),
(7, ' NEPSE.today is an effort to assist in managing your nepal stock exchange porftfolio. We have tried our best to provide you with the latest stock transaction data and accurate calculations as far as possible. However, there are still be several glitches and rooms for improvement. Should you find any glitches, we shall try to fix them ASAP to make this system more robust. Please understand that this application is a beta release and will undergo massive changes in the days ahead to come.', 1, '2017-07-23 15:58:42', b'1'),
(8, 'एकान्त छ, शान्त छ, यहि छ प्रक्रितिकाे चलनएकान्त छ, शान्त छ, यहि छ प्रक्रितिकाे चलनएकान्त छ, शान्त छ, यहि छ प्रक्रितिकाे चलनएकान्त छ, शान्त छ, यहि छ प्रक्रितिकाे चलनएकान्त छ, शान्त छ, यहि छ प्रक्रितिकाे चलनएकान्त छ, शान्त छ, यहि छ प्रक्रितिकाे चलनएकान्त छ, शान्त छ, यहि छ प्रक्रितिकाे चलनएकान्त छ, शान्त छ, यहि छ प्रक्रितिकाे चलनएकान्त छ, शान्त छ, यहि छ प्रक्रितिकाे चलनएकान्त छ, शान्त छ, यहि छ प्रक्रितिकाे चलनएकान्त छ, शान्त छ, यहि छ प्रक्रितिकाे चलनएकान्त छ, शान्त छ, यहि छ प्रक्रितिकाे चलनएकान्त छ, शान्त छ, यहि छ प्रक्रितिकाे चलनएकान्त छ, शान्त छ, यहि छ प्रक्रितिकाे चलनएकान्त छ, शान्त छ, यहि छ प्रक्रितिकाे चलनएकान्त छ, शान्त छ, यहि छ प्रक्रितिकाे चलनएकान्त छ, शान्त छ, यहि छ प्रक्रितिकाे चलनएकान्त छ, शान्त छ, यहि छ प्रक्रितिकाे चलनएकान्त छ, शान्त छ, यहि छ प्रक्रितिकाे चलनएकान्त छ, शान्त छ, यहि छ प्रक्रितिकाे चलनएकान्त छ, शान्त छ, यहि छ प्रक्रितिकाे चलनएकान्त छ, शान्त छ, यहि छ प्रक्रितिकाे चलनएकान्त छ, शान्त छ, यहि छ प्रक्रितिकाे चलनएकान्त छ, शान्त छ, यहि छ प्रक्रितिकाे चलनएकान्त छ, शान्त छ, यहि छ प्रक्रितिकाे चलनएकान्त छ, शान्त छ, यहि छ प्रक्रितिकाे चलनएकान्त छ, शान्त छ, यहि छ प्रक्रितिकाे चलनएकान्त छ, शान्त छ, यहि छ प्रक्रितिकाे चलनएकान्त छ, शान्त छ, यहि छ प्रक्रितिकाे चलनएकान्त छ, शान्त छ, यहि छ प्रक्रितिकाे चलनएकान्त छ, शान्त छ, यहि छ प्रक्रितिकाे चलनएकान्त छ, शान्त छ, यहि छ प्रक्रितिकाे चलन', 1, '2017-07-23 15:59:49', b'1'),
(9, 'Its a nice website. Thank you huge\n\nNava', 1, '2017-07-25 15:18:32', b'1'),
(10, '', 92, '2017-07-26 07:01:36', b'1'),
(11, '', 92, '2017-07-26 07:01:39', b'1'),
(12, '', 92, '2017-07-26 07:02:07', b'1'),
(13, '', 1, '2017-07-30 06:49:11', b'1'),
(14, '', 1, '2017-08-22 12:45:07', b'1'),
(15, 'not operating system', 61, '2017-08-31 09:38:54', b'1'),
(16, 'Hi Admin,\n\nWhenever I add stocks into the system, It allows to save multiple times. I trust this is a bug and needs to be rectified ASAP. \n\nThanking you in advance,\nUserA', 1, '2017-09-07 04:05:43', b'1'),
(17, 'Market Rate is sorted via name in descending ', 55, '2017-09-07 04:13:19', b'1'),
(18, 'Market Rate is sorted via name in descending ', 55, '2017-09-07 04:13:20', b'1'),
(19, 'Hi, \n\nThis is a test mail\n\nNava', 1, '2017-11-19 06:43:27', b'1'),
(20, 'Hello Admin,Thank you for your free nepse portfolio system.i am enjoying with this system but i have face some problem.I don\'t see how to reset or delete data which i have enter by mistake.So,could you please reset my account.\n\nThank you\nGhanashyam Kasti', 130, '2017-11-30 05:56:02', b'1'),
(21, 'Garrett Cantrell, who is not a Scientologist, recalled his time at the school as he sat near Clearwater’s harbor, surrounded by Scientologist retreat centers. The school was small and private, exactly what Cantrell was seeking in a high school after moving to Florida from New York in 2008.', 11, '2017-12-12 16:10:02', b'1'),
(22, 'how to remove unlisted shown on the list which was mistakely entered the data. please help us\n', 171, '2018-03-05 10:28:50', b'1'),
(23, 'I started using this site. Thank you for your effort, I knew from Mr Kushal Niraula about this site. \nHow to see remarks here?', 168, '2018-03-08 03:26:16', b'1'),
(24, 'The software is not calculating total worth correctly.', 168, '2018-03-08 11:16:44', b'1'),
(25, 'कृपया net worth review गर्नु हाेला। कुल जम्मा गरेकाे मिलेन।\nतीर्थ', 168, '2018-03-09 09:52:46', b'1'),
(26, 'Thank you. Today this software started to work. \n', 168, '2018-03-12 04:44:21', b'1'),
(27, '  नवजी, अाज KADBL को Edit गर्न मिलेन । Edit को कुनै अप्सन देखाउदैन। Data not available देखाउछ । अनि फेरी थप एक Item entry  गरेँ त्यो पनि देखाएन । यसमा quantity, cost, high low,  investment and net-worth  देखाउछ।नेटवर्थ calculation market price संग मिल्दैन।\n अरु १८ वटा कम्पनीहरुको entry ठिक छ ।', 168, '2018-03-14 01:29:57', b'1'),
(28, 'what is wrong with this site? multiple entries entered of same script and deleted my previous script?? fix it guys', 171, '2018-03-14 06:17:03', b'1'),
(29, 'my quantity is increasing without my entry... what is the reason', 171, '2018-03-14 07:42:14', b'1'),
(30, 'what kind of bug is this , quantity has been changing anonymously\n', 143, '2018-03-14 08:03:28', b'1'),
(31, 'Could you please remove my stock with following detail\nHImal\n32	665.22								UNLISTED	21,287.04	254,175.95 \nIt was mistakenly entered but could not remove after.\n\nThanks in advance\n', 171, '2018-03-15 03:06:13', b'1'),
(32, 'Quantity changes without entering physically? what the hell please fix it asap\n', 143, '2018-03-15 09:45:38', b'1'),
(33, 'Nava jee, I think it started working properly.\nHow to save this page in pdf or word for daily record?\n', 168, '2018-03-16 02:08:42', b'1'),
(34, 'Market Opportunity lost and gain needed', 55, '2018-05-23 07:40:58', b'1'),
(35, 'Change the thank you message', 55, '2018-05-23 07:41:18', b'1'),
(36, 'Black text in Blue Gradient does not suit ', 55, '2018-05-23 07:41:52', b'1'),
(37, 'LIVE traded value are not being loaded correctly', 102, '2018-07-08 08:10:39', b'1'),
(38, 'how to delet my wrong entrys\n', 188, '2018-08-17 14:08:31', b'1');
