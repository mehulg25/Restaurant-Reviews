-- Drop Views

DROP VIEW dbo.Peak_hours;
DROP VIEW dbo.Best_branch;
DROP VIEW dbo.User_tips;
DROP VIEW dbo.Best_branch_reviews;


-- To find the peak hours when customers visit Starbucks to be well prepared and avoid under-staffing.

CREATE VIEW dbo.Peak_hours AS
(Select DATEPART(HOUR, [checkInValue]) AS 'Hour Of The Day' , COUNT(*) AS 'Number Of Check Ins' from [BUDT703_Project_0503_07].[dbo].[Terp.CheckIn]
GROUP BY DATEPART(HOUR, [checkInValue]));

SELECT * FROM dbo.Peak_hours;

-- To determine the Starbucks branch with the highest customer rating.

CREATE VIEW dbo.Best_branch AS
Select b.businessName AS 'Business', CONCAT(b.businessAddress, ', ', b.businessCity, ', ', b.businessState, ', ',b.businessPostalCode) AS 'Business Address', b.businessStars AS 'Business Rating', b.businessIsOpen AS 'Is Open?', b.businessHours AS 'Timings'
from [dbo].[Terp.Business] b 
where b.businessStars = (Select max(businessStars) from [dbo].[Terp.Business] ) ;

SELECT * FROM dbo.Best_branch;

-- To get feedback of the lowest rated business in order to improve.

CREATE VIEW dbo.User_tips AS
Select b.businessName AS 'Business', CONCAT(b.businessAddress, ', ', b.businessCity, ', ', b.businessState, ', ',b.businessPostalCode) AS 'Business Address', b.businessStars AS 'Business Rating',  t.tipText AS 'Feedback'
from [dbo].[Terp.Business] b inner join [dbo].[Terp.Tip] t on b.businessId = t.businessId
where b.businessStars = (Select min(businessStars) from [dbo].[Terp.Business] ) ;

SELECT * FROM dbo.User_tips;

-- To find the reviews of the highest-rated Starbucks branch in order to improve other branches.

CREATE VIEW dbo.Best_branch_reviews AS
Select  b.businessName AS 'Business', CONCAT(b.businessAddress, ', ', b.businessCity, ', ', b.businessState, ', ',b.businessPostalCode) AS 'Business Address', b.businessStars AS 'Business Rating', r.reviewText AS 'Reviews'
from [dbo].[Terp.Business] b inner join [dbo].[Terp.Review] r ON b.businessId = r.businessId
where b.businessStars = (Select max(businessStars) from [dbo].[Terp.Business]);

SELECT * FROM dbo.Best_branch_reviews;