USE BUDT703_Project_0503_07;

BEGIN TRANSACTION;

-- Altering tables

IF EXISTS (
	SELECT *
	FROM INFORMATION_SCHEMA.TABLES
	WHERE TABLE_NAME = 'Terp.CheckIn' AND TABLE_SCHEMA = 'dbo' )
	ALTER TABLE [Terp.CheckIn]
		DROP CONSTRAINT IF EXISTS fk_CheckIn_businessId;

IF EXISTS (
	SELECT *
	FROM INFORMATION_SCHEMA.TABLES
	WHERE TABLE_NAME = 'Terp.CheckIn' AND TABLE_SCHEMA = 'dbo' )
	ALTER TABLE [Terp.CheckIn]
		DROP CONSTRAINT IF EXISTS fk_CheckIn_userId;

IF EXISTS (
	SELECT *
	FROM INFORMATION_SCHEMA.TABLES
	WHERE TABLE_NAME = 'Terp.Tip' AND TABLE_SCHEMA = 'dbo' )
	ALTER TABLE [Terp.Tip]
		DROP CONSTRAINT IF EXISTS fk_Tip_businessId;

IF EXISTS (
	SELECT *
	FROM INFORMATION_SCHEMA.TABLES
	WHERE TABLE_NAME = 'Terp.Tip' AND TABLE_SCHEMA = 'dbo' )
	ALTER TABLE [Terp.Tip]
		DROP CONSTRAINT IF EXISTS fk_Tip_userId;

IF EXISTS (
	SELECT *
	FROM INFORMATION_SCHEMA.TABLES
	WHERE TABLE_NAME = 'Terp.Tip' AND TABLE_SCHEMA = 'dbo' )
	ALTER TABLE [Terp.Tip]
		DROP CONSTRAINT IF EXISTS fk_Tip_userId;

IF EXISTS (
	SELECT *
	FROM INFORMATION_SCHEMA.TABLES
	WHERE TABLE_NAME = 'Terp.Review' AND TABLE_SCHEMA = 'dbo' )
	ALTER TABLE [Terp.Review]
		DROP CONSTRAINT IF EXISTS fk_Review_businessId;

IF EXISTS (
	SELECT *
	FROM INFORMATION_SCHEMA.TABLES
	WHERE TABLE_NAME = 'Terp.Review' AND TABLE_SCHEMA = 'dbo' )
	ALTER TABLE [Terp.Review]
		DROP CONSTRAINT IF EXISTS fk_Review_userId;


-- Dropping tables

DROP TABLE IF EXISTS [Terp.checkIn];
DROP TABLE IF EXISTS [Terp.Tip];
DROP TABLE IF EXISTS [Terp.Review];
DROP TABLE IF EXISTS [Terp.User];
DROP TABLE IF EXISTS [Terp.Business];


-- Creating Tables

CREATE TABLE [Terp.Business] (
businessId VARCHAR (6) NOT NULL,
businessName VARCHAR (20),
businessAddress VARCHAR (50),
businessCity VARCHAR (20),
businessState VARCHAR (20),
businessPostalCode VARCHAR (5),
businessStars DECIMAL (3),
businessReviewCount INT,
businessIsOpen BIT,
businessHours VARCHAR (200),
CONSTRAINT pk_Employee_businessId PRIMARY KEY (businessId)
)

CREATE TABLE [Terp.User] (
userId VARCHAR (6) NOT NULL,
userName VARCHAR (30),
userReviewCount INT,
userAverageStar DECIMAL (3),
CONSTRAINT pk_User_userId PRIMARY KEY(userId)
)

CREATE TABLE [Terp.Review] (
reviewId VARCHAR(6) NOT NULL,
userId VARCHAR (6) NOT NULL,
businessId VARCHAR (6) NOT NULL,
reviewStars INT,
reviewDate DATE,
reviewText VARCHAR (5000),
CONSTRAINT pk_Review_reviewId PRIMARY KEY (reviewId),
CONSTRAINT fk_Review_userId FOREIGN KEY (userId)
		REFERENCES [Terp.User] (userId)
		ON DELETE NO ACTION ON UPDATE CASCADE,
CONSTRAINT fk_Review_businessId FOREIGN KEY (businessId)
		REFERENCES [Terp.Business] (businessId)
		ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE [Terp.Tip](
tipId VARCHAR (6) NOT NULL,
businessId VARCHAR (6) NOT NULL,
userId VARCHAR (6) NOT NULL,
tipText VARCHAR (1000),
CONSTRAINT pk_Tip_tipId PRIMARY KEY(tipId),
CONSTRAINT fk_Tip_userId FOREIGN KEY (userId)
		REFERENCES [Terp.User] (userId)
		ON DELETE NO ACTION ON UPDATE CASCADE,
CONSTRAINT fk_Tip_businessId FOREIGN KEY (businessId)
		REFERENCES [Terp.Business] (businessId)
		ON DELETE NO ACTION ON UPDATE CASCADE
)

CREATE TABLE [Terp.CheckIn](
checkInId VARCHAR (6) NOT NULL,
userId VARCHAR (6) NOT NULL,
businessId VARCHAR (6) NOT NULL,
checkInValue DATETIME,
CONSTRAINT pk_CheckIn_checkInId PRIMARY KEY(checkInId),
CONSTRAINT fk_CheckIn_userId FOREIGN KEY (userId)
		REFERENCES [Terp.User] (userId)
		ON DELETE NO ACTION ON UPDATE CASCADE,
CONSTRAINT fk_CheckIn_businessId FOREIGN KEY (businessId)
		REFERENCES [Terp.Business] (businessId)
		ON DELETE NO ACTION ON UPDATE CASCADE
)


-- Inserting Data

INSERT INTO [Terp.Business] VALUES 
('b00001','Starbucks','4750 Cherry Hill Rd','College Park','MD','20740','3','62','1','Mon: 5:00 AM - 10:00 PM , Tue: 5:00 AM - 10:00 PM, Wed: 5:00 AM - 10:00 PM, Thu: 5:00 AM - 10:00 PM, Fri: 5:00 AM - 10:00 PM, Sat: 6:00 AM - 10:00 PM, Sun: 6:00 AM - 9:00 PM'),
('b00002','Starbucks','6100 Greenbelt Rd Target','Greenbelt','MD','20770','1','3','1','Mon: 8:00 AM - 9:00 PM, Tue: 8:00 AM - 9:00 PM, Wed: 8:00 AM - 9:00 PM, Thu: 8:00 AM - 9:00 PM, Fri: 8:00 AM - 9:00 PM, Sat: 8:00 AM - 9:00 PM, Sun: 8:00 AM - 9:00 PM'),
('b00003','Starbucks','7336 Baltimore Ave','College Park','MD','20740','3.5','41','1','Mon: 6:00 AM - 9:00 PM, Tue: 6:00 AM - 9:00 PM, Wed: 6:00 AM - 9:00 PM, Thu: 6:00 AM - 9:00 PM, Fri: 6:00 AM - 9:00 PM, Sat: 7:00 AM - 9:00 PM, Sun: 7:00 AM - 9:00 PM'),
('b00004','Starbucks','4501 Van Buren St','Riverdale Park','MD','20737','2.5','19','1','Mon: 6:00 AM - 9:00 PM, Tue: 6:00 AM - 9:00 PM, Wed: 6:00 AM - 9:00 PM, Thu: 6:00 AM - 9:00 PM, Fri: 6:00 AM - 9:00 PM, Sat: 6:00 AM - 9:00 PM, Sun: 6:00 AM - 9:00 PM'),
('b00005','Starbucks','10906 Baltimore Ave','Beltsville','MD','20705','3.5','31','1','Mon: 5:00 AM - 9:00 PM, Tue: 5:00 AM - 9:00 PM, Wed: 5:00 AM - 9:00 PM, Thu: 5:00 AM - 9:00 PM, Fri: 5:00 AM - 9:30 PM, Sat: 6:00 AM - 8:30 PM, Sun: 6:30 AM - 8:30 PM');

INSERT INTO [Terp.User] VALUES 
('u00001','Katrina L.','265','3'),
('u00002','Nana M.','34','3.5'),
('u00003','Dezaree J.','6','2'),
('u00004','Donyiel C.','1182','3'),
('u00005','Demond S.','829','3'),
('u00006','Richard C.','51','2'),
('u00007','Mike B.','1078','4'),
('u00008','Karla V.','594','3.8'),
('u00009','Jason P.','20','1.5'),
('u00010','Kathy C.','11','2'),
('u00011','Anna Jagun','2','3'),
('u00012','Ahmed Al-Ghabban','8','3.13'),
('u00013','Nirvanaa','8','2.75'),
('u00014','Esme Vz','11','4.8'),
('u00015','Sarah Crider','11','3.8'),
('u00016','Lynne L.','48','2.8'),
('u00017','Karla C.','1','1'),
('u00018','Desiree Alvarez','77','3'),
('u00019','ReggieReg','61','4.6'),
('u00020','Angie Woodrick','39','3.7'),
('u00021','Muhammad Ehtisham','97','4.6'),
('u00022','Lillian Warfield','4','2.8'),
('u00023','Leandro Pavon','6','3'),
('u00024','Diya Datta','1','5'),
('u00025','Monica Alvarenga Barrera','2','3'),
('u00026','Federico Iuricich','13','5'),
('u00027','Luca Maro','117','4.2'),
('u00028','Bonnie Vona','3','5'),
('u00029','Mariana Z.','10','4.4'),
('u00030','Amber M.','317','3.4'),
('u00031','Cornelius G.','69','2.7'),
('u00032','Nessa R.','573','2'),
('u00033','Julia G.','1','5'),
('u00034','Faithful N.','33','2'),
('u00035','Bobby Y.','451','3'),
('u00036','Courtney F.','55','3.5'),
('u00037','Jonathan E.','21','1'),
('u00038','Melvin B.','77','2.75'),
('u00039','Kamrie R.','26','4.5'),
('u00040','Jay S.','185','2'),
('u00041','Paul Maison','5','3.5'),
('u00042','Micheal Adams','1','5'),
('u00043','Vassiliki Eley','9','4.4'),
('u00044','Only One','53','4.2'),
('u00045','Pamela Goins','87','4'),
('u00046','Earl Carter','19','3.7'),
('u00047','J Boughner','1','1'),
('u00048','Mike B','1078','4.6'),
('u00049','Donyiel C.','1182','3.2'),
('u00050','Jeena L.','362','4.1'),
('u00051','Danny R.','34','4'),
('u00052','Neha A.','576','3.2'),
('u00053','Yatin K.','34','4.7'),
('u00054','Sumanth Thyagarajan','476','3.4'),
('u00055','Rahul Dutta','53','4'),
('u00056','Shiv V.','1','2'),
('u00057','Muskaan Bajpayee','14','4'),
('u00058','Raghav C.','2','1'),
('u00059','Varun Goswami','674','2.7'),
('u00060','Kitty P.','832','3'),
('u00061','Mukundhan Raj','76','2.4'),
('u00062','Aneesh Chorisetty','12','4.6'),
('u00063','Steve V.','43','2.4'),
('u00064','Mark H.','65','3.6'),
('u00065','James H.','87','4.2'),
('u00066','Rupith Baburaj','33','3.7'),
('u00067','Jennie Josh','1','1'),
('u00068','Max V.','5','3');

INSERT INTO [Terp.Review] VALUES 
('r00001','u00001','b00001','4','2020-12-09','Exceptional customer service is why we Yelp right? Then this location deserves all the praise for amazing customer service! You see, this SBUX is one of the only ones in the area open late(r) than most, so I used the app to order a White Chocolate Mocha Latte from here around 9:15 PM on a Sunday. Imagine my horror when I arrived close to closing time and the baristas told me that they didn''t have my order - though I had already paid in the app. It wasn''t until I doubled checked the app and noticed I had put in my order to another SBUX in College Park - and not the one where I was standing. To add insult to injury, that location was closed. Then, imagine my pleasant surprise when the barista told me that they would make the drink I had ordered elsewhere, since I had a receipt to prove I had already spent the money. I''m not sure if that''s corporate policy, but I was so amazed at their willingness to help so close to closing time that I thanked the staff profusely and had to shout them out where it counts...on Yelp!'),
('r00002','u00002','b00001','4','2019-07-04','This is a great drive thru location, where the line usually moves pretty fast and the drinks are always made perfectly to your specifications. This location also stays open to 10pm most nights, which is later than most other locations in the DMV area. I got to enjoy one of the holiday drinks, the Caramel Brulee Latte, and it was amazing!!!!! Hot but not scalding, and tasted great. Definitely recommend.'),
('r00003','u00003','b00001','1','2020-12-09','Very Rude! Not one person greeted me nor did they say your welcome. It''s the simplest things that make the world a better place.'),
('r00004','u00004','b00001','4','2018-10-30','One of my fave Sbux locations in the DMV! It''s been here like forever. The customer service is always on point and there''s a drive-through! On this chilly, almost winter day I pre-ordered a Grande Caramel Brulee Latte. I arrived a few minutes later and went to the drive-through to get my warm, delicious drink! It was made just right! There are times when the line here has been insane but still find this to be a great location!'),
('r00005','u00005','b00001','4','2019-01-24','Nothing like starting the day with your favorite beverage. Starbucks is always consistent in perfomance, service, and quality. This location is one of two that I know of that has a drive-thru.'),
('r00006','u00006','b00001','1','2019-03-15','It wasn''t an amazing experience for me.  Approximately 2 months ago, I went to the drive-thru after 9pm for my daily Frappuccino because the app said they were open until 10pm. I ordered from home and the lights were out around 9:20.  This attitude of indifference towards the customer is disappointing.  I understand it''s the weekend and maybe the employees want to party but the customers need to know if you''re going to lock the doors early.'),
('r00007','u00007','b00001','4','2020-02-26','Drive thru Starbucks up in this B! The drive thru isn''t particularly place VERY well tbh. Most of the time, the line of cars stops people from entering the side of the parking lot where the Starbucks is... but they do move quickly; and they usually have more than enough staff on hand. No complaints with this SB. ALOT of students from nearby UMD come here and work on their laptops. They do have the sucky chairs with no back support, which is why I usually don''t hang out here. But this is my goto Starbucks for dropping by before I head to Peg Leg Vintage which is just one minute away. And we all know how much I''m at Peg Leg Vintage ;)'),
('r00008','u00008','b00001','5','2021-11-01','Five stars for genuine care and the most amazing costumer service in the Metropolitan Area. I needed to spare some time so I figured to go to Starbucks because I love their coffee and rewards program. I never thought I would get the most caring costumer service. I asked for a Venti Caramel Latte. The barista prompt some questions to make sure I was getting exactly what I wanted and told me  what he was giving me. He nailed it! I ended up spending more time there than I originally thought so I ended up ordering a venti tea. Barista took his time to explain me the different teas and caffeine levels, also when I requested hot water and not boiling he had no problem making sure it was exactly how I wanted. They were busy but moving. The place is clean with a great environment. Highly recommend this specific location.'),
('r00009','u00009','b00001','1','2021-11-05','The slowest service ever. It took 30 minutes to get my drink and I overheard them tell 5 customers they were out of breakfast sandwiches. Do yourself a favor, go across the street to DD.'),
('r00010','u00010','b00001','1','2020-12-01','So disappointing after so many years but the drinks are just NOT what they have been. Even special orders are NOT right. Speaking to manager no help. Done!  Won''t be back!'),
('r00011','u00011','b00002','1','2018-11-12','I wasted my money twice here . They need to train the staff how to make good starbuck coffee.'),
('r00012','u00012','b00002','1','2020-10-22','I was in line… the lady who works there turned the lights off and went to the back saying “break time” after helping 3 customers ahead of me! So rude… I waited over 15 minutes and she’s not there.'),
('r00013','u00013','b00002','5','2021-11-11','I get really excited when I go in and V!! Is making my drinks! She’s great! She always makes my drinks really good and CONSISTENTLY good! Really nice and easy to talk too! I love their personality. Definitely made this Starbucks worth going too!'),
('r00014','u00014','b00002','5','2020-03-07','excellent customer service and they prepare delicious cappuccinos'),
('r00015','u00015','b00002','3','2019-10-10','I’m disappointed that this location doesn’t accept the Starbucks rewards app, but I understand that may not be their choice but a Target policy. My not so positive rating comes from the rude service I received by a barista that couldn’t be bothered to look up from her phone to take my order.'),
('r00016','u00016','b00002','1','2020-12-05','This is the worst Starbucks location in the area. Only one person ever working here, no order ahead. Just a waste of time. Often out of espresso beans so they say they can''t make any espresso drinks. I''m, can''t you just get them @ Target?!!! SMH'),
('r00017','u00017','b00002','1','2017-12-29','Worst starbucks ever. went in to get 3 drinks and i start naming them and she tells me there is no whip. How do you not have whip? Then I ask for the strawberry Açai lemonade and she also said she didn''t have it.'),
('r00018','u00018','b00002','1','2021-11-24','First off, I''ll start by saying that I rarely order Starbucks and I''m vegan, so I''m not too familiar with the menu, the couple times I''ve visited other locations the employees have been so sweet! But at this location, it was a young woman and a gentleman working behind the area, it''s 10/10/19 at 6:40pm, I walk up to the counter, I was after a woman who apparently had an issue with her order, so the employee, the female, already had a foul attitude to start. I walked up to the counter and told the lady "hey I''m vegan so I''m not sure what to order, I want some type of coffee, something sweet with almond milk" she doesn''t say hi and just gives me an annoyed look. She tells me about a drink they have and though it sounded good, I asked her about the hot chocolate instead and if it could be made vegan, her response ? "You said you wanted coffee." I said "well yea, but now I wanted to know about the hot chocolate." She proceeds to say yes it can be made, rings me up for the drink and then proceeds to ignore me to listen to what the previous customer was complaining about, I wait for my receipt, something she never offered, and just stared at me and said "you go over THERE to wait for your drink." She was so impolite and dismissive, it was disappointing. Very sad, the few times I visit Starbucks I always have great things to say, but this time was just horrible.'),
('r00019','u00019','b00002','3','2021-10-01','Friendly baristas and drinks are always tasty unlike Safeway Starbucks where they never come out quite right.'),
('r00020','u00020','b00002','4','2021-03-02','The Very Berry Hibiscus especially! Pretty much anything on the menu!'),
('r00021','u00021','b00003','5','2021-07-01','It''s my all-time favorite place.'),
('r00022','u00022','b00003','1','2021-02-05','I wish I could give 0 starts. Says people spend 10 minutes here…I waited for 20 minutes as They don’t understand pickup orders. If I’m placing an order for pickup my order should already be in the order. When I show up. People who ordered at the register AFTER I placed my order get their food first. MAKES NO SENSE AND DEFEATS THE PURPOSE. also your cashier with purple hair needs to go I watched her make at least 3 rude comments during the time I was there to other customers who were just as frustrated waiting 20 minutes for an order that was ordered ahead.'),
('r00023','u00023','b00003','5','2017-11-27','Late night stop, didn’t have what I wanted; however, they made it work and it taste great! Thanx'),
('r00024','u00024','b00003','5','2019-11-23','I didn’t catch their name, but a certain barista at this starbucks changed my whole day recently. I was having the absolute worst day and picking up a mobile order, and the barista told me they were out of cinnamon raisin bagels and asked me if an everything bagel was fine. Which of course it is, who am I to be picky? I thought nothing of it until they handed me a gift card and said “this should cover the next bagel.” This small gesture really helped me take on a brand new perspective and genuinely brightened my day, so much that I’m still thinking about it. Thank you, kind soul!'),
('r00025','u00025','b00003','5','2019-12-05','People who work here are Awesome young lady who was assisting me today was extremely nice ,good customer service'),
('r00026','u00026','b00003','5','2016-09-25','Clean, fast service and comfortable seats. Best coffee place in College Park.'),
('r00027','u00027','b00003','5','2016-07-23','So grateful this place was open early on game day. There was already a little line and they were low staffed but they worked through it pretty fast. The barista making the coffee was pretty cool too and he did a great job. I was impressed with this place. They needed to mop by the pickup area though.'),
('r00028','u00028','b00003','5','2019-04-23','I hosted a conference and needed 6 Carry out coffee jugs at 7:15am. Everything was ready when I arrived - coffee boxes, sweeteners, napkins, cups... And I was able to purchase 2 bottles of flavored syrup. The manager Rick was incredibly friendly & helpful, both when I called in the order and when picking up. He loaded my car for me. I will definitely order from this store in the future'),
('r00029','u00029','b00003','5','2020-08-29','This is a great place to work or study. The environment is ideal to get some work done, with lots of students, and it is relatively quiet. It has lots of comfortable seating space. The wifi works great and there are outlets under the tables to plug in your laptop.'),
('r00030','u00030','b00003','4','2021-03-14','So much seating! My typical complaint about most locations is about there lack of seating and/or outlets. This location got it right with a large array of comfy armchairs, high chairs, and tables..and plenty of outlets. Too bad this one is so far from me,otherwise I''d be here regularly!'),
('r00031','u00031','b00004','3','2020-07-27','It''s cool. An average Starbucks that''s typically packed with stay-at-home dads and University of Maryland students. One thing I have noticed is that they tend to make the sweet drinks less sweet than other locations. I don''t know if that''s on purpose or by chance but my vanilla sweet cream cold brew, and my mango dragonfruit refreshers be a lil too tart compared to my usual locations near the DC Costco and the Capital Heights location. Hmmmm *looks over glasses in suspicion*'),
('r00032','u00032','b00004','3','2018-08-29','Love love love this area! Love this location. I just don''t like the hours. Yes! Even before Covid they closed early. Overall everything usually okay. Sometimes the berries lack at this location but I''m guessing new baristas are to blame? Not sure. They aren''t always nice like other locations but I did come in during COVID and the guy was a gem, they were about to close but he helped me out. They are only doing app orders for now!'),
('r00033','u00033','b00004','5','2019-09-26','this is the best starbucks ever. They are so supportive and kind and always smiley. Love it here!!!!'),
('r00034','u00034','b00004','1','2019-06-16','This Starbucks location is incapable of handling a rush. Best to mobile order to avoid interacting with flustered baristas and unprofessional managers.  I ordered an americano and a cold brew. I was told by, I believe the manager, that the cold brew wasn''t ready so I asked for a second americano instead. This manager prepared one americano then immediately walked away. I had to wait way too long to have the same drink made again. Pure laziness.  The baristas seem friendly and kind enough but you can tell who the managers are and how negligent they are.'),
('r00035','u00035','b00004','4','2018-08-19','Fruit flies are a thing of the past. There *are* two house flies buzzing around right now but that''s passable. I do like how there is always a rotating special coffee brew on tap at this location and the staff is one of the most competent and friendly you will experience in the area. Cheers to the management for assembling a great team. With Whole Foods right next door with their $2 self-serve single brew, this Starbucks needs to remain on point. Their free wifi is fast and reliable and keeps you signed on after the first login, which is nice.'),
('r00036','u00036','b00004','4','2019-06-02','You can definitely tell people come here for coffee and WiFi. I had the emperors cloud mist tea today, I love how they give you two tea bags it was extra strong like I love it. My experience was quick and easy nobody really in line around 950am. Also I love the fact there is parking in the back and I didn''t have to look long for a spot. Customer service was nice, will go back. Like this location. Only thing is while I had my laptop the charger part was going in and out. I am not sure if it works right.'),
('r00037','u00037','b00004','1','2017-12-03','They are normally fine and the buildout is great. But today''s service was horrendous. After watching 6-8 drinks sitting on the counter unclaimed and 12-15 mins later I asked if they had my drink. They tried to claim someone must have taken it. No - I was standing there the whole time. No one retrieved a drink. There were three of them too busy socializing and gabbing to get orders correct. I left after realizing I would be behind 3-4 other people whose orders were also wrong. Like I get it the job is mundane but take pride in whatever you do. This was beyond sloppy and unprofessional and half your store was unhappy with you.'),
('r00038','u00038','b00004','2','2021-09-03','They close at 8pm. It is just getting dark. They should stay open later. There is a Whole Food next door that has good coffee. I will be going there next.'),
('r00039','u00039','b00004','5','2021-06-27','This place is really the best! As a graduate student, I spend a lot of time in coffee shops and this place never disappoints. My drinks are always made correctly and in a timely manner. I typically get the same thing (hot caramel macchiato or latte) but the baristas help me venture out and try new things based on my taste that day. Sudan, Ysamar, Lauren, and Abby are always really friendly and outgoing to customers! There''s also almost always seating. On a Saturday morning, it might be a bit busy, but that''s expected. Otherwise, I almost always get a spot. This place also has really big windows, so there''s nice natural light and there''s a Whole Foods next door if you need some snacks.'),
('r00040','u00040','b00004','1','2021-10-30','The past three times I''ve visited this location was excellent. However, the trip I made today was less than ideal. There is a Barista with bright pink hair that was very unprofessional and rude. She was not only rude to me, but the customer in front of me. She even walked to another worker and whispered something in her ear. I don''t think I would be visiting this location ever again. They both then looked at us and laughed. They were frustrated that we wanted to use the app for points.'),
('r00041','u00041','b00005','1','2021-11-24','This location is inconsistent with their service. Granted it can not always be a great experience for a combination of reasons but my experience here over the past year has been a bit of a let down. The lines are long and move very slowly. Cars often are backed out to route one but when you drive around you can see a bottle neck happening between the ordering window and the pick up window. I assume this helps them game their timer on service but it is unsafe for the people on the main road. In addition to that, I''ve been to this location on multiple occasions between 5-6 am and there''s been no one in the store to provide service. Once, I brought it up and the cashier told me I was wrong, someone was here. The culture here is lacking and honestly I believe the store manager is responsible. I''ve met her, she''s hot and cold. I''ve had my coffee spill right out of the cop directly onto me due to poor cups and an overall lack of concern from the cashier to confirm that the cup and top both are fitted properly. Overall, Saturdays are a no go. You can assure bad service and a long wait. Apparently, staffing is not a concern on weekends here. The final blow for me happened today, after a long wait 10 minute wait in line I approached the window for the cashier to tell me that there is no Pike Place Coffee. If you''re asking, why don''t you go inside? Take a trip to this location and you will find that there is no time difference between service speed inside and out. Overall, I just started going to the laurel location up the street and it has been a night and day difference in service. I''m a long time customer of Starbucks and this is my first review ever. That being said, the service here SUCKS!'),
('r00042','u00042','b00005','5','2021-10-31','I still love Starbucks after all the years I’ve had Starbucks Delivered almost every day had the virus in a rehab in laurel love you all!'),
('r00043','u00043','b00005','5','2021-11-10','I just got a coffee and almond croissant and had a lovely experience. Sweet staff, beautiful people and excellent service. 10/10 recommend'),
('r00044','u00044','b00005','5','2021-05-28','This Shout Out goes to Jordan. I always have a good experience when I visit this location which isn''t often since I relocated but however Jordan made my last visit extra special for two reasons: 1st My drink was made perfect. 2ed She remembered my Dogs name which really surprise me and made me and my doggie feel special...(him)when she gave him that Puppuccino.'),
('r00045','u00045','b00005','4','2021-07-19','You know how this goes, good coffee, location good, service very good ! Stop in and enjoy the drink ! Parking is available!'),
('r00046','u00046','b00005','5','2021-11-15','This is my office away from home. Quiet, productive environment.'),
('r00047','u00047','b00005','1','2021-10-21','My son had an office online order that apparently got mixed up on Starbucks end.  He arrived to pick up the order and every drink was incorrect.  The employee decided to blast my son in front of the other customers and tell him it was stealing or that he was trying to “get over” on her!  My son asked to speak to the manager and of course, the manager wasn’t there!  The employee ripped off her apron and proceeded to yell and scream!  The “supervisor “ was basically a yes man and did nothing to help the situation!  Mind you, my son is black!  Accusing a customer of stealing or getting over in front of others because of her mistake is unacceptable!  Sorry Starbucks!  You lost more customers!  Hello, is the Dunkin’?'),
('r00048','u00048','b00005','5',NULL,'I have to say, out of all the Starbucks in the area ( and I mean IN THE AREA). Like... Montgomery County, Prince George''s County, and Frederick. I have to say that I probably have received the most consistently great service at this Starbucks. The Kentlands Starbucks has also treated me really right, but this Starbucks definitely stands out a bit. I know me a Starbucks. And after years and years of trying I finally think I got my drink order right. Iced Grande Coffee in a Venti Cup Unsweetened Extra Ice Extra Cream Wanna hear some mind-numbing personalized information that won''t contribute anything to your life? Did I hear a yes? So I used to ordered a Iced Grande Coffee in a Venti cup unsweetened. They''d always ask me if I wanted extra ice or extra room. I''d bounce back and forth in between the two. Sometimes when I asked for extra ice it wouldn''t allow enough room for the amount of cream I wanted to put in. Sometimes when I opted for extra room, the little ice in my drink would melt and it would be a not so iced coffee. Well the pandemic changed all of that. Since I couldn''t add the cream myself, I had to start asking for cream in my order. And, I don''t know if it''s just me (it likely is) but I put a pretty specific amount of cream in my coffee. I like a decent amount, but when I would ask Starbucks for "Extra Cream" then they would put in too much. It felt like I was just drinking a cup of cream with a hint of coffee extract. So, I came up with the former. I''d ask for extra ice so that they couldn''t add too too much cream... but like just enough. And guess what?! It like works 90 percent of the time! Now that I''ve robbed you of 2 minutes of your life that you''ll never get back, let me get back to this Starbucks. This is a drive through Starbucks ( probably should have been in the first line of the review). This is a drive through one and it''s also fairly new. The only time that this Starbucks has disappointed me was during the pandemic when I saw the drive in line super long and went to walk into the store to just place my order in person and the inside was closed. It was weird, cause it wasn''t at like the height of the pandemic when it happened. This was like a few months ago. I''m sure they have their reasoning. Either way, whenever I go in, even though they''re super busy with drive through orders- they always acknowledge my presence and tell me that they''ll be right with me. The bathrooms are generally pretty clean and available. There''s a lot of space to sit inside and usually it''s not crowded. I believe they''ve opened up some of their tables for inside dining now. I mean... I enjoy going to this Starbucks. Definitely, if I have a choice of Cherry Hill Vs. this one. I definitely opt for this one. Cherry Hill the bathrooms have needed a good deal of help when I''ve stopped in on a number of occasions. There''s little to no seating at Cherry Hill cause it''s usually taken up by college kids and telecommuters. And the service I''ve found not as warm. Not cold, but definitely not as warm. It seems like the Beltsville Starbucks Staff really jives well together. Cheers to you Starbucks Beltsville. Amongst the 742 Starbucks I''ve been to in my life, you are definitely near the top of the heap.'),
('r00049','u00049','b00005','3',NULL,'It''s that time of year! The holiday drinks are back. I was excited to indulge in a caramel brulee latte, one of my favorite Starbucks drinks. Sadly this drink was terrible. Like I couldn''t even finish it. Maybe it was just an off day but won''t be impressed to return. The drive-thru line was soooo long!'),
('r00050','u00050','b00005','4',NULL,'Good decent customer service. Early hours. Serves americano, iced teas, desserts, and breakfast sandwiches.');

INSERT INTO [Terp.Tip] VALUES 
('t00001','b00001','u00051','More scope to improve the menu'),
('t00002','b00001','u00052','Can use better milk'),
('t00003','b00001','u00053','I would love if they serve soy milk'),
('t00004','b00001','u00054','I am a vegan, I wish they served organic milk'),
('t00005','b00001','u00055','I really like starbucks but the menu is soexpensive. They should lower down these prices.'),
('t00006','b00002','u00056','Seating is very uncomfortable'),
('t00007','b00002','u00057','They should get better chairs with backrests'),
('t00008','b00002','u00058','Not enough chairs for everyone to sit. '),
('t00009','b00002','u00059','Increase the seating capacity'),
('t00010','b00002','u00060','Utilizie the space more efficiently'),
('t00011','b00003','u00061','The employees are so arrogant. You should hire better people'),
('t00012','b00003','u00062','Rude behaviour by the cashier.'),
('t00013','b00003','u00063','Give your staff better training'),
('t00014','b00003','u00064','Make stronger coffees'),
('t00015','b00003','u00065','You should serve organic milk as well.'),
('t00016','b00004','u00066','Update your menu. I am tired of the same old menu.'),
('t00017','b00004','u00067','Very crowded, the staff is slow, I had to wait 30 minutes for my order'),
('t00018','b00004','u00068','Great service! No feedback');

INSERT INTO [Terp.CheckIn] VALUES 
('c00001','u00010','b00001','2021-01-26 09:23:54'),
('c00002','u00015','b00002','2021-07-01 10:32:43'),
('c00003','u00023','b00003','2018-04-30 09:00:03'),
('c00004','u00025','b00003','2018-02-21 11:14:43'),
('c00005','u00026','b00003','2021-03-19 09:16:03'),
('c00006','u00030','b00003','2020-10-21 09:43:56'),
('c00007','u00035','b00004','2020-10-02 09:01:34'),
('c00008','u00039','b00004','2019-11-30 09:34:12'),
('c00009','u00007','b00001','2019-12-15 11:05:36'),
('c00010','u00041','b00005','2021-10-10 09:23:55'),
('c00011','u00045','b00005','2021-10-21 09:01:43');

COMMIT;