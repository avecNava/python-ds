
--
-- Indexes for dumped tables
--

--
-- Indexes for table `nepse_article`
--
ALTER TABLE `nepse_article`
  ADD PRIMARY KEY (`article_id`);

--
-- Indexes for table `nepse_company`
--
ALTER TABLE `nepse_company`
  ADD PRIMARY KEY (`company_id`);

--
-- Indexes for table `nepse_company_type`
--
ALTER TABLE `nepse_company_type`
  ADD PRIMARY KEY (`type_id`);

--
-- Indexes for table `nepse_data`
--
ALTER TABLE `nepse_data`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `nepse_feedback`
--
ALTER TABLE `nepse_feedback`
  ADD PRIMARY KEY (`feedback_id`);

--
-- Indexes for table `nepse_login`
--
ALTER TABLE `nepse_login`
  ADD PRIMARY KEY (`login_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `nepse_metadata`
--
ALTER TABLE `nepse_metadata`
  ADD PRIMARY KEY (`row_id`);

--
-- Indexes for table `nepse_portfolio`
--
ALTER TABLE `nepse_portfolio`
  ADD PRIMARY KEY (`Portfolio_id`),
  ADD KEY `Symbol` (`Symbol`);

--
-- Indexes for table `nepse_shareholder`
--
ALTER TABLE `nepse_shareholder`
  ADD PRIMARY KEY (`shareholder_id`);

--
-- Indexes for table `nepse_share_group`
--
ALTER TABLE `nepse_share_group`
  ADD PRIMARY KEY (`GroupID`);

--
-- Indexes for table `nepse_tradedate`
--
ALTER TABLE `nepse_tradedate`
  ADD PRIMARY KEY (`symbol`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `nepse_article`
--
ALTER TABLE `nepse_article`
  MODIFY `article_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=132;

--
-- AUTO_INCREMENT for table `nepse_company`
--
ALTER TABLE `nepse_company`
  MODIFY `company_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=740;

--
-- AUTO_INCREMENT for table `nepse_company_type`
--
ALTER TABLE `nepse_company_type`
  MODIFY `type_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `nepse_feedback`
--
ALTER TABLE `nepse_feedback`
  MODIFY `feedback_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `nepse_login`
--
ALTER TABLE `nepse_login`
  MODIFY `login_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=237;

--
-- AUTO_INCREMENT for table `nepse_portfolio`
--
ALTER TABLE `nepse_portfolio`
  MODIFY `Portfolio_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1709;

--
-- AUTO_INCREMENT for table `nepse_shareholder`
--
ALTER TABLE `nepse_shareholder`
  MODIFY `shareholder_id` int(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=275;

--
-- AUTO_INCREMENT for table `nepse_share_group`
--
ALTER TABLE `nepse_share_group`
  MODIFY `GroupID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
