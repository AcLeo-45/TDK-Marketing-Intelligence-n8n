-- ============================================
-- CREATE TABLES
-- ============================================

CREATE TABLE users (
  user_id INT PRIMARY KEY AUTO_INCREMENT,
  user_name VARCHAR(255),
  company_name VARCHAR(255),
  region VARCHAR(50),
  department VARCHAR(100),
  is_active_sub BOOLEAN,
  signup_date DATETIME,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE campaigns (
  campaign_id INT PRIMARY KEY AUTO_INCREMENT,
  campaign_name VARCHAR(255),
  channel VARCHAR(50),
  budget_allocated DECIMAL(10, 2),
  start_date DATE,
  end_date DATE,
  status VARCHAR(20),
  target_region VARCHAR(50),
  campaign_owner VARCHAR(100),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE leads (
  lead_id INT PRIMARY KEY AUTO_INCREMENT,
  first_name VARCHAR(100),
  last_name VARCHAR(100),
  email VARCHAR(255),
  company_name VARCHAR(255),
  industry VARCHAR(100),
  lead_source VARCHAR(50),
  lead_quality_score INT,
  campaign_id INT,
  signup_date DATETIME,
  last_activity_date DATETIME,
  region VARCHAR(50),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (campaign_id) REFERENCES campaigns(campaign_id)
);

CREATE TABLE conversion_events (
  event_id INT PRIMARY KEY AUTO_INCREMENT,
  lead_id INT,
  campaign_id INT,
  event_type VARCHAR(50),
  event_value DECIMAL(10, 2),
  timestamp DATETIME,
  page_url VARCHAR(500),
  device_type VARCHAR(20),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (lead_id) REFERENCES leads(lead_id),
  FOREIGN KEY (campaign_id) REFERENCES campaigns(campaign_id)
);

CREATE TABLE marketing_spend (
  spend_id INT PRIMARY KEY AUTO_INCREMENT,
  campaign_id INT,
  channel VARCHAR(50),
  spend_date DATE,
  amount_spent DECIMAL(10, 2),
  impressions INT,
  clicks INT,
  conversions INT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (campaign_id) REFERENCES campaigns(campaign_id)
);

-- ============================================
-- INSERT SAMPLE DATA
-- ============================================

-- Users
INSERT INTO users (user_name, company_name, region, department, is_active_sub, signup_date) VALUES
('Acme Corp', 'Acme Corporation', 'US', 'Marketing', TRUE, '2024-01-15 10:30:00'),
('TechStart Inc', 'TechStart Inc', 'EU', 'Sales', TRUE, '2024-02-20 14:45:00'),
('Global Solutions', 'Global Solutions Ltd', 'APAC', 'Marketing', FALSE, '2024-03-10 09:15:00'),
('Digital Ventures', 'Digital Ventures Co', 'US', 'Sales', TRUE, '2024-04-05 11:20:00'),
('Cloud Innovators', 'Cloud Innovators Inc', 'EU', 'Marketing', TRUE, '2024-01-25 16:30:00');

-- Campaigns
INSERT INTO campaigns (campaign_name, channel, budget_allocated, start_date, end_date, status, target_region, campaign_owner) VALUES
('Q4 Email Campaign', 'Email', 5000.00, '2024-10-01', '2024-10-31', 'Completed', 'US', 'John Doe'),
('Summer Social Push', 'Social', 15000.00, '2024-07-01', '2024-08-31', 'Completed', 'EU', 'Jane Smith'),
('Fall Paid Search', 'Paid Search', 20000.00, '2024-09-15', '2024-11-15', 'Active', 'US', 'Mike Johnson'),
('Winter Webinar Series', 'Email', 8000.00, '2024-11-01', '2024-12-31', 'Active', 'APAC', 'Sarah Lee'),
('LinkedIn B2B Campaign', 'Social', 12000.00, '2024-09-01', '2024-10-31', 'Completed', 'EU', 'Tom Brown'),
('Content Marketing Push', 'Content', 6000.00, '2024-08-15', '2024-10-15', 'Completed', 'US', 'Lisa Anderson'),
('Referral Program Q4', 'Referral', 3000.00, '2024-10-01', '2024-12-31', 'Active', 'US', 'John Doe'),
('Trade Show Sponsorship', 'Event', 25000.00, '2024-10-15', '2024-10-20', 'Completed', 'EU', 'Jane Smith');

-- Leads (Sample)
INSERT INTO leads (first_name, last_name, email, company_name, industry, lead_source, lead_quality_score, campaign_id, signup_date, last_activity_date, region) VALUES
('Alice', 'Johnson', 'alice.johnson@email.com', 'Tech Corp', 'Technology', 'Organic', 85, 1, '2024-10-05 09:00:00', '2024-10-20 14:30:00', 'US'),
('Bob', 'Smith', 'bob.smith@email.com', 'Finance Inc', 'Finance', 'Paid Ad', 72, 3, '2024-09-20 10:15:00', '2024-10-18 11:45:00', 'US'),
('Carol', 'Davis', 'carol.davis@email.com', 'Health Solutions', 'Healthcare', 'Email', 65, 1, '2024-10-12 08:30:00', '2024-10-19 16:20:00', 'US'),
('David', 'Wilson', 'david.wilson@email.com', 'EU Retail Ltd', 'Retail', 'Social', 78, 2, '2024-07-15 13:00:00', '2024-10-17 09:00:00', 'EU'),
('Emma', 'Martinez', 'emma.martinez@email.com', 'Asia Growth Co', 'E-commerce', 'Referral', 92, 7, '2024-10-08 11:30:00', '2024-10-21 15:00:00', 'APAC'),
('Frank', 'Taylor', 'frank.taylor@email.com', 'Global Analytics', 'Analytics', 'Content', 58, 6, '2024-09-01 14:45:00', '2024-10-16 10:00:00', 'US'),
('Grace', 'Lee', 'grace.lee@email.com', 'EU SaaS Startup', 'SaaS', 'Event', 88, 8, '2024-10-18 12:00:00', '2024-10-21 13:30:00', 'EU'),
('Henry', 'Brown', 'henry.brown@email.com', 'Manufacturing Pro', 'Manufacturing', 'Organic', 45, 3, '2024-08-20 09:30:00', '2024-10-10 14:00:00', 'US');

-- Conversion Events (Sample)
INSERT INTO conversion_events (lead_id, campaign_id, event_type, event_value, timestamp, page_url, device_type) VALUES
(1, 1, 'Click', 0.00, '2024-10-05 09:15:00', 'www.example.com/email-landing', 'Desktop'),
(1, 1, 'Download', 0.00, '2024-10-05 09:45:00', 'www.example.com/download', 'Desktop'),
(1, 1, 'Demo Request', 0.00, '2024-10-07 10:30:00', 'www.example.com/demo', 'Desktop'),
(2, 3, 'Click', 0.00, '2024-09-22 10:20:00', 'www.example.com/search-landing', 'Mobile'),
(2, 3, 'Page View', 0.00, '2024-09-22 10:25:00', 'www.example.com/product', 'Mobile'),
(2, 3, 'Download', 0.00, '2024-09-25 14:00:00', 'www.example.com/whitepaper', 'Desktop'),
(3, 1, 'Open', 0.00, '2024-10-12 09:00:00', 'www.example.com/email', 'Mobile'),
(3, 1, 'Click', 0.00, '2024-10-12 09:10:00', 'www.example.com/email-landing', 'Mobile'),
(4, 2, 'Click', 0.00, '2024-07-20 13:30:00', 'www.example.com/social-landing', 'Mobile'),
(4, 2, 'Purchase', 500.00, '2024-08-10 15:45:00', 'www.example.com/checkout', 'Desktop'),
(5, 7, 'Click', 0.00, '2024-10-10 11:45:00', 'www.example.com/referral-landing', 'Mobile'),
(5, 7, 'Demo Request', 0.00, '2024-10-12 14:00:00', 'www.example.com/demo', 'Desktop'),
(5, 7, 'Purchase', 1200.00, '2024-10-15 16:30:00', 'www.example.com/checkout', 'Desktop'),
(6, 6, 'Page View', 0.00, '2024-09-02 15:00:00', 'www.example.com/blog-post', 'Desktop'),
(7, 8, 'Click', 0.00, '2024-10-19 12:15:00', 'www.example.com/event-landing', 'Desktop'),
(7, 8, 'Demo Request', 0.00, '2024-10-19 13:00:00', 'www.example.com/demo', 'Desktop'),
(7, 8, 'Purchase', 2500.00, '2024-10-21 10:00:00', 'www.example.com/checkout', 'Desktop');

-- Marketing Spend (Daily)
INSERT INTO marketing_spend (campaign_id, channel, spend_date, amount_spent, impressions, clicks, conversions) VALUES
(1, 'Email', '2024-10-01', 150.00, 5000, 250, 5),
(1, 'Email', '2024-10-02', 160.00, 5200, 280, 6),
(1, 'Email', '2024-10-05', 140.00, 4800, 240, 4),
(3, 'Paid Search', '2024-09-15', 800.00, 25000, 1200, 45),
(3, 'Paid Search', '2024-09-16', 850.00, 26000, 1300, 52),
(3, 'Paid Search', '2024-09-20', 900.00, 28000, 1400, 58),
(2, 'Social', '2024-07-05', 450.00, 15000, 600, 15),
(2, 'Social', '2024-07-10', 480.00, 16000, 700, 18),
(2, 'Social', '2024-08-15', 500.00, 18000, 800, 22),
(4, 'Email', '2024-11-01', 200.00, 6000, 300, 8),
(5, 'Social', '2024-09-01', 400.00, 12000, 480, 12),
(6, 'Content', '2024-08-15', 150.00, 8000, 320, 8),
(7, 'Referral', '2024-10-01', 100.00, 2000, 150, 10),
(8, 'Event', '2024-10-15', 5000.00, 500, 150, 35);

-- ============================================
-- VERIFY DATA
-- ============================================

SELECT COUNT(*) as total_users FROM users;
SELECT COUNT(*) as total_campaigns FROM campaigns;
SELECT COUNT(*) as total_leads FROM leads;
SELECT COUNT(*) as total_events FROM conversion_events;
SELECT COUNT(*) as total_spend FROM marketing_spend;