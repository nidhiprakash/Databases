CREATE TABLE nsuryapr.Race (Race_ID INT PRIMARY KEY IDENTITY(1,1),Race_name VARCHAR(50)NOT NULL)

CREATE TABLE nsuryapr.State (State_ID INT PRIMARY KEY IDENTITY(1,1),State_name VARCHAR(50) NOT NULL)

CREATE TABLE nsuryapr.Gender(Gender_ID INT PRIMARY KEY IDENTITY(1,1),gender char(20) NOT NULL)

CREATE TABLE nsuryapr.Country(Country_ID INT PRIMARY KEY IDENTITY(1,1),CountryName VARCHAR(50) NOT NULL)

CREATE TABLE nsuryapr.Address (Address_ID INT PRIMARY KEY IDENTITY(1,1),Street1 varchar(50) NOT NULL,
Street2 varchar(20),State_ID INT NOT NULL REFERENCES nsuryapr.State(State_ID),City char(10),Zipcode VARCHAR(50) NOT NULL,
Country_ID INT REFERENCES nsuryapr.Country(Country_ID))

CREATE TABLE nsuryapr.Person_Info (Person_ID INT PRIMARY KEY IDENTITY(1,1),NTID varchar(10),
password varchar(15) ,SSN varchar(10),FirstName varchar(20) NOT NULL,LastName varchar(20) NOT NULL,
MiddleName varchar(20),DOB date,Gender_ID INT NOT NULL REFERENCES nsuryapr.Gender(Gender_ID),
Race_ID INT NOT NULL REFERENCES nsuryapr.Race(Race_ID),Email_address varchar(20) NOT NULL,
Address_ID INT NOT NULL REFERENCES nsuryapr.Address(Address_ID) ,Cell_phone VARCHAR(50))

Alter table nsuryapr.Person_Info
alter COLUMN Cell_phone VARCHAR(50)

/* Student */

CREATE TABLE nsuryapr.StudentType (StudentType_ID INT PRIMARY KEY IDENTITY(1,1),type VARCHAR(50))

CREATE TABLE nsuryapr.StudentStatus (StudentStatus_ID INT PRIMARY KEY IDENTITY(1,1),status VARCHAR(50))

CREATE TABLE nsuryapr.StudentLevel (studentLevel_ID INT PRIMARY KEY IDENTITY(1,1),Level VARCHAR(50))

CREATE TABLE nsuryapr.Student (Student_ID INT REFERENCES nsuryapr.Person_Info(Person_ID),
StudentType_ID INT NOT NULL REFERENCES nsuryapr.StudentType(StudentType_ID),
StudentStatus_ID INT NOT NULL REFERENCES nsuryapr.StudentStatus(StudentStatus_ID),
StudentLevel_ID INT NOT NULL REFERENCES nsuryapr.StudentLevel(StudentLevel_ID),PRIMARY KEY(Student_ID))

CREATE TABLE nsuryapr.College(College_ID INT PRIMARY KEY IDENTITY(1,1),College_name VARCHAR(50))

CREATE TABLE nsuryapr.majorAndminor (Concentration_ID INT PRIMARY KEY IDENTITY(1,1),
Title varchar(50),College_ID INT REFERENCES nsuryapr.College(College_ID))

CREATE TABLE nsuryapr.StudentConcentration (Student_ID INT REFERENCES nsuryapr.Person_Info(Person_ID),
Concentration_ID INT REFERENCES nsuryapr.majorAndminor(Concentration_ID),isMajor BIT,
PRIMARY KEY(Student_ID,Concentration_ID))

Alter table nsuryapr.Job_Information
alter COLUMN max_pay VARCHAR(50)

/*employee*/

CREATE TABLE nsuryapr.CoverType(Cover_type_ID INT PRIMARY KEY IDENTITY(1,1),CoverType_plan varchar(50))

CREATE TABLE nsuryapr.InsuranceType(Insurance_for_ID INT PRIMARY KEY IDENTITY(1,1),benefit_type char(20) NOT NULL)

CREATE TABLE nsuryapr.Job_Type(Jobtype_ID INT PRIMARY KEY IDENTITY(1,1),job_type char(50)NOT NULL)

CREATE TABLE nsuryapr.Benefits (Insurance_ID INT PRIMARY KEY IDENTITY(1,1),
Insurance_for_ID INT REFERENCES nsuryapr.InsuranceType(Insurance_for_ID),
Cover_type_ID INT REFERENCES nsuryapr.CoverType(Cover_type_ID),
Employee_PA VARCHAR(50) NOT NULL,Employer_PA VARCHAR(50) NOT NULL)

CREATE TABLE nsuryapr.Job_Information (Job_code INT PRIMARY KEY IDENTITY(1,1),Job_title varchar(20) NOT NULL,
Job_description VARCHAR(200),Jobtype_ID INT NOT NULL REFERENCES nsuryapr.Job_Type(Jobtype_ID),
min_pay VARCHAR(50) NOT NULL,max_pay VARCHAR(50) NOT NULL, isFaculty BIT NOT NULL)

CREATE TABLE nsuryapr.Employee (Employee_ID INT REFERENCES nsuryapr.Person_Info(Person_ID),
Annual_Salary varchar(20) NOT NULL,PRIMARY KEY(Employee_ID))

CREATE TABLE nsuryapr.Employee_Benefits (Employee_ID INT REFERENCES nsuryapr.Employee(Employee_ID),
Insurance_ID INT REFERENCES Benefits(Insurance_ID),PRIMARY KEY(Employee_ID,Insurance_ID))

CREATE TABLE nsuryapr.JobOfEmployee(Employee_ID INT REFERENCES nsuryapr.Employee(Employee_ID),
Job_code INT REFERENCES nsuryapr.Job_Information(Job_code),PRIMARY KEY(Employee_ID,Job_code))

Alter table nsuryapr.CourseLevel
alter COLUMN Level_info VARCHAR(200)

/*courses*/

CREATE TABLE nsuryapr.Buildings(Building_ID INT PRIMARY KEY IDENTITY(1,1),Building_name VARCHAR(50))

CREATE TABLE nsuryapr.EquipmentInfo(Equipment_ID INT PRIMARY KEY IDENTITY(1,1),Instrument_info VARCHAR(50)

CREATE TABLE nsuryapr.EnrollmentStatus(EnrollmentStatus_ID INT PRIMARY KEY IDENTITY(1,1),estatus char(20))

CREATE TABLE nsuryapr.Classroom(Classroom_ID INT PRIMARY KEY IDENTITY(1,1),
Building_ID INT REFERENCES nsuryapr.Buildings(Building_ID),
Capacity INT,Floor_number INT NOT NULL,Class_number INT NOT NULL,
Equipment_ID INT REFERENCES nsuryapr.EquipmentInfo(Equipment_ID))

CREATE TABLE nsuryapr.SemesterType(SemesterType_ID INT PRIMARY KEY IDENTITY(1,1),Sem_type char(10))

CREATE TABLE nsuryapr.SemesterInfo(Semester_ID INT PRIMARY KEY IDENTITY(1,1),
SemesterType_ID INT REFERENCES SemesterType(SemesterType_ID),
Year INT NOT NULL,begin_date date,last_date date)

CREATE TABLE nsuryapr.DEPARTMENT(DEPARTMENT_ID INT PRIMARY KEY IDENTITY(1,1),Dept_name VARCHAR(50))

CREATE TABLE nsuryapr.CourseLevel(CourseLevel_ID INT PRIMARY KEY IDENTITY(1,1),Level_info VARCHAR(200))

CREATE TABLE nsuryapr.CourseDetails(Course_code INT,Course_number INT IDENTITY(1,1),
Title_course varchar(50),
Description varchar(50),DEPARTMENT_ID INT REFERENCES nsuryapr.DEPARTMENT(DEPARTMENT_ID) NOT NULL ,
CourseLevel_ID INT REFERENCES nsuryapr.CourseLevel(CourseLevel_ID),
credit_hours INT,PRIMARY KEY(Course_code,Course_number))

CREATE TABLE nsuryapr.CourseTimings(Timings_ID INT PRIMARY KEY IDENTITY(1,1),StartTime VARCHAR(50),EndTime VARCHAR(50),
day char(10),minutes INT not NULL)

Alter table nsuryapr.CourseDetails
alter COLUMN Course_code VARCHAR(50)

CREATE TABLE nsuryapr.Prereqs(Prereq_ID INT PRIMARY KEY IDENTITY(1,1),
Parentcode INT NOT NULL,
Childcode INT not NULL,
Parentnumber INT NOT NULL,
Childnumber INT NOT NULL,
FOREIGN KEY(Parentcode,Parentnumber) REFERENCES nsuryapr.CourseDetails(Course_code,Course_number),
FOREIGN KEY(Childcode,Childnumber) REFERENCES nsuryapr.CourseDetails(Course_code,Course_number))

CREATE TABLE nsuryapr.Course_schedule(CRN INT PRIMARY KEY IDENTITY(1,1),
Course_code INT NOT NULL,
Course_number INT NOT NULL,
Semester_ID INT REFERENCES nsuryapr.SemesterInfo(Semester_ID),
Timings_ID INT REFERENCES CourseTimings(Timings_ID),Classroom_ID INT REFERENCES nsuryapr.Classroom(Classroom_ID),
FOREIGN KEY (Course_code,Course_number) REFERENCES nsuryapr.CourseDetails(Course_code,Course_number))

CREATE TABLE CourseEnrollment(Student_ID INT REFERENCES nsuryapr.Student(Student_ID),
CRN INT REFERENCES nsuryapr.Course_schedule(CRN),
EnrollmentStatus_ID INT REFERENCES nsuryapr.EnrollmentStatus(EnrollmentStatus_ID),
midterm_grade VARCHAR(50) not NULL,
final_grade VARCHAR(50) NOT NULL, PRIMARY KEY(Student_ID,CRN))

CREATE TABLE EmployeeAndCourse(CRN INT REFERENCES nsuryapr.Course_schedule(CRN),
Employee_ID INT REFERENCES nsuryapr.Employee(Employee_ID),PRIMARY KEY(CRN,Employee_ID))

Alter table nsuryapr.CourseEnrollment
alter COLUMN final_grade VARCHAR(50)

/*Insert statements */

Insert into nsuryapr.Race values 
('White'),
('Black/African American'),
('American Indian/Alaska Native'),
('Asian'),
('Native Hawaiian');


Insert into nsuryapr.Gender Values 
('Male'),
('Female'),
('Other');

Insert into nsuryapr.State Values ('Alabama'),('Alaska'),('Arizona'),('Arkansas'),
('California'),('Colorado'),('Connecticut'),('Delaware'),('Florida'),('Georgia'),
('Hawaii'),('Idaho'),('Illinois'),('Indiana'),('Iowa'),('Kansas'),('Kentucky'),
('Louisiana'),('Maine'),('Maryland'),('Massachusetts'),('Michigan'),('Minnesota'),
('Mississippi'),('Missouri'),('Montana'),('Nebraska'),('Nevada'),('New Hampshire'),
('New Jersey'),('New Mexico'),('New York'),('North Carolina'),('North Dakota'),
('Ohio'),('Oklahoma'),('Oregon'),('Pennsylvania'),('Rhode Island'),('South Carolina'),
('South Dakota'),('Tennessee'),('Texas'),('Utah'),('Vermont'),('Virginia'),('Washington'),
('West Virginia'),('Wisconsin'),('Wyoming');

Insert into nsuryapr.State Values ('Karnataka')

Insert into nsuryapr.Country Values ('United States'),('India'),('China'),
('Bangladesh'),('Srilanka'),('Japan'),('France'),('Nepal'),('Russia');

/* --- */

insert into nsuryapr.StudentStatus values ('Active'),('Inactive'),('Suspended');

insert into nsuryapr.StudentType values('New Freshmen'),('Continue'),('Transfer'),('Re-Admitted'),
('New Graduate'),('Continue Graduate');

insert into nsuryapr.EnrollmentStatus values('Enrolled'),('Dropped'),('Audit');

insert into nsuryapr.StudentLevel values('Undergraduate'),('Graduate');

insert into nsuryapr.EquipmentInfo values('Projector1'),('Projector2'),('Projector3'),('Projector4'),
('Projector5'),('Projector6'),('Projector7'),('Projector8'),('Projector9'),('Projector10');

insert into nsuryapr.Job_Type values ('Staff'),('Faculty');

insert into nsuryapr.SemesterType values('Fall'),('Spring'),('Winter'),('Summer');

insert into nsuryapr.InsuranceType values('Health'),('Denatal'),('Vision');

insert into nsuryapr.CoverType values('Employee Only'),('Employee With Children Only'), ('Employee With Spouse Only'), ('Employee With Family');

/* 2nd level inserts */

Insert into nsuryapr.Address values('440 Westcott street','Apt 1',32,'Syracuse','13210',1),
('101 dell street',NULL,32,'Syracuse','13210',1),
('100 Judson street','Apt 1',32,'Syracuse','13210',1),
('2017 East Genesse street','Apt 3',32,'Syracuse','13210',1),
('1115 East Genesse street',NULL,32,'Syracuse','13210',1),
('543 Columbus ave','Apt 2',32,'Syracuse','13210',1),
('101 Euclid Avenue',NULL,32,'Syracuse','13210',1),
('544 Jayanagar','5th block',51,'Bangalore','560041',2),
('220 JP nagar','1stPhase',51,'Bangalore','560042',2),
('555 Banashankari','2nd stage',51,'Bangalore','560071',2);

Insert into nsuryapr.Address values('488 Westcott street','Apt 2',32,'Syracuse','13210',1),
('1147 South campus','Apt 1',32,'Syracuse','13210',1),
('2019 Euclid ave','Apt 3',32,'Syracuse','13210',1)




Insert into nsuryapr.College VALUES ('Falk College'),
('EECS'),
('Whitman'),
('School of Information Studies'),
('College of Law');

INSERT INTO nsuryapr.Person_Info values('nsuryapr','pwd123','12345','Nidhi','Prakash',NULL,'1995-05-24',2,7,'nsuryapr@syr.edu',7,'3156641844'),
('apmahaja','pwd234','23456','Anuja','Mahajan','P','1991-10-22',2,7,'apmahaja@syr.edu',1,'3156641841'),
('ndange','pwd456','78901','Nikhil','Dange','Nishikanth','1995-12-08',1,10,'ndange@syr.edu',10,'3156641845'),
('sshaikh',NULL,'67891','Sofiya','Shaikh',NULL,'1993-07-19',2,9,'sshaikh@syr.edu',9,'3156694789'),
('masheth','pwd789','11123','Manushi','Sheth','Manish','1995-09-19',2,10,'masheth@syr.edu',2,'2135827908'),
('maujawan',NULL,'78654','Malhar','Ujawane',NULL,'1995-08-27',1,9,'maujawan@syr.edu',3,'3167739265'),
('viagrawa','pwd455','43561','Vikas','Agrawal',NULL,'1992-01-26',1,8,'viagrawa@syr.edu',1,'2637186054'),
('akjagtap',NULL,'67234','Akshay','Jagtap',NULL,'1995-03-23',1,10,'akjagtap@syr.edu',4,'3159259935'),
('kvasudev','pwd555','55777','Kunal','Vasudev',NULL,'1995-05-04',1,8,'kvasudev@usc.edu',2,'2135924630'),
('megsanj',NULL,'24561','Meghana','Sanjay',NULL,'1995-05-15',2,7,'megsanj@uic.edu',7,'2124416678'),
('khebbar','pwd890','67240','Kushal','Hebbar','Sriram','1995-04-22',1,9,'khebbar@clem.edu',4,'8900022661'),
('apkemkar',NULL,'32410','Apurva','Kemakr',NULL,'1995-09-24',2,7,'apkemkar@syr.edu',8,'4028976541');

INSERT INTO nsuryapr.Person_Info values('lwang','pwd544','777654','Li','Wang',NULL,'1985-05-07',2,10,'liwang@syr.edu',11,'31566418444'),
('edmyu','pwd665','11122','Edmund','Yu',NULL,'1975-04-02',2,10,'edmyu@syr.edu',12,'3156641325'),
('ercer','pwd007','11122','Ercanlli','Erhart',NULL,'1980-02-12',2,10,'ercer@syr.edu',13,'3156641325');




Delete from nsuryapr.Person_Info

DBCC CHECKIDENT ('Person_Info', RESEED, 0)

INSERT INTO nsuryapr.Student values(1,1,1,2),
(7,2,1,1),
(2,3,1,2),
(3,4,1,2),
(4,5,1,1),
(5,6,1,1),
(9,1,1,2),
(10,2,1,1),
(11,2,1,1),
(6,4,2,2);

INSERT INTO nsuryapr.majorAndminor values('Data Science',2),
('Art of Homemaking',1),
('Business Analytics',3),
('Project Management',4),
('Artificial Intelligence',1),
('Criminal Law',5);

INSERT INTO nsuryapr.StudentConcentration VALUES(1,1,1),
(2,5,1),
(3,1,1),
(4,3,1),
(9,1,1),
(5,6,0),
(6,4,0),
(10,2,1);

INSERT into nsuryapr.SemesterInfo values
(2,2018,'2018-01-16','2018-05-10'),
(4,2018,'2018-06-29','2018-10-10'),
(1,2018,'2018-07-28','2018-12-14'),
(3,2019,'2019-01-02','2019-03-26'),
(2,2019,'2019-01-14','2019-05-08'),
(4,2019,'2019-05-13','2019-08-23'),
(1,2019,'2019-08-22','2019-12-15'),
(3,2020,'2020-01-02','2020-03-24'),
(2,2020,'2020-01-15','2020-05-16');

INSERT into nsuryapr.Benefits values (1,3,'5000','10000'),
(2,1,'7000','6500'),
(3,1,'10000','10000'),
(3,2,'5000','7500'),
(1,4,10000,3000),
(2,3,6500,10000);

INSERT into nsuryapr.Job_Information VALUES('Lecturer','Provide support to academic staff and focus on enhancing the student learning and teaching experience',2,'35000','50000',1),
('Associate Professor','academic leader delivering high quality, student centred teaching (research, knowledge exchange or professional practice)',2,'15000','25000',1),
('Program co-ordinator','Program coordinators work with staff members, budgets, and procedures to ensure the implementation and success of programs. ',1,'12000','15000',0),
('Asssitant Professor','Guide, Lead and mentor students in research projects',2,'20000','30000',1),
('Full professor','Teaching related appointment with an expectation for scholarly accomplishment',2,'30000','50000',1)

Insert into nsuryapr.Employee VALUES(8,'35000'),
(12,'32000'),
(13,'40000'),
(14,'38000'),
(15,'30000')

INSERT into nsuryapr.Employee_Benefits VALUES (8,4),
(12,3),(13,6),(14,1),(15,2)

INSERT into nsuryapr.JobOfEmployee VALUES (8,5),(12,1),(13,5),(14,1),(15,1)

INSERT into nsuryapr.CourseTimings VALUES('9:30 am','10:30 am','Monday',60),
('11:00 am','12:00 pm','Tuesday',90),('5:00 pm','6:35 pm','Wednesday',95),('7:00 pm','8:00 pm','Thursday',60),('3:00 pm','4:15 pm','Monday',75)

Insert into nsuryapr.DEPARTMENT values
('BIOMEDICAL & CHEMICAL ENGINEERING'),
('CIVIL & ENVIRONMENTAL ENGINEERING'),
('ELECTRICAL ENGINEERING & COMPUTER SCIENCE'),
('MECHANICAL & AEROSPACE ENGINEERING'),
('Human Development and Family Science'),
('Sport Management'),
('Entrepreneurship and Emerging Enterprises'),
('Finance Management'),
('Marketing Management'),
('Real Estate'),
('Retail Management'),
('Supply Chain Management');

DELETE FROM DEPARTMENT

DBCC CHECKIDENT ('DEPARTMENT', RESEED, 0)

INSERT into nsuryapr.Buildings values
('Link Hall'),
('Watson Theater'),
('Life Sciences'),
('Slocum Hall'),
('Bird Library'),
('Bowne Hall'),
('Steel Hall'),
('Hinds Hall');

INSERT into nsuryapr.Classroom VALUES
(1,60,3,312,16),(4,30,4,401,11),(7,90,2,234,13),(2,150,5,500,12),(3,100,3,311,20)

INSERT into nsuryapr.CourseLevel values('Undergraduate'),('Graduate');

DELETE FROM Classroom

DBCC CHECKIDENT ('Classroom', RESEED, 0)

INSERT into CourseDetails VALUES
(581,'Database Management systems','Understanding the databases',3,2,50),
(610,'Business Analytics','Concepts on how the real Business works',8,2,55),
(314,'Operations Reasearch','maximizing profits and minimizing costs',12,1,45),
(455,'Project Management','Experiencing real-world project managaing issues',7,1,38),
(523,'Family relations','Understanding how and what relationships are',5,1,35),
(628,'Fluid mechanics','The mechanics behind fluids and thrust',4,2,40)

INSERT into CourseDetails VALUES
(678,'Object oriented design','Design knowledge with C++',3,2,55),
(701,'Design Patterns','Learning how to reuse algorithms',3,2,35),
(765,'Data Warehousing','Managament of data warehouse structures',8,2,45),
(627,'Family and child intervention','Advanced Coursework for family understnading',5,1,40),
(538,'Intro to mechanics','The mechanics beginning',4,2,43),
(522,'Data Analytics','Advnaced data enagagement',3,2,55)

INSERT into nsuryapr.Prereqs VALUES
(701,678,8,7),
(765,581,9,1),
(627,523,10,5),
(628,538,6,11),
(522,581,12,1)

INSERT into nsuryapr.Course_schedule VALUES
(581,1,3,4,2),
(314,3,4,1,2),
(628,6,3,2,3),
(701,8,5,3,4),
(522,12,1,5,5)

INSERT into CourseEnrollment VALUES
(1,1,1,'A-','A+'),
(2,1,1,'A+','A+'),
(3,4,1,'A-','A-'),
(4,5,1,'B-','B+'),
(5,2,3,'A-','B+'),
(6,3,1,'C-','B-'),
(9,4,2,'A+','A+')

INSERT INTO nsuryapr.EmployeeAndCourse VALUES
(2,8),(3,12),(1,13),(4,14),(5,15)













