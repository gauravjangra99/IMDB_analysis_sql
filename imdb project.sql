select * from earning
select * from IMDB
select * from genre


---Which movies have the highest domestic and worldwide earnings?

--Domestic highest grosser
select top 1  b.Title , a.Domestic from earning a
join  IMDB b
on a.Movie_id =b.movie_id 
order by a.domestic desc;    

--worldwide highest grosser
select top 1  b.Title , a.Worldwide from earning a
join  IMDB b
on a.Movie_id =b.movie_id 
order by a.Worldwide desc;

---highest rated movie 
select title , votesimdb , TotalVotes from imdb 
order by VotesIMDB  desc, TotalVotes desc

--- is there any correlation between rating of a movie and boxoffice collection
select a.Title ,  a.VotesIMDB ,b.Worldwide from IMDB a
join earning b
on a.Movie_id =b.movie_id 
order by a.VotesIMDB desc , b.Worldwide



----Which genres are most common in the dataset?
select  genre , COUNT(genre) as 'Count'  from genre
group by genre
order by Count desc
 

----What is the average rating for each genre?
select a.genre , count(a.genre) as 'count of movies' , avg(b.votesimdb) as 'avg rating'
from genre as a 
join imdb as b
on a.Movie_id=b.Movie_id 
group by a.genre 
order by [count of movies] desc, [avg rating] desc


----Which genre has the highest average earnings?
select  a.genre , sum(b.Worldwide)  as 'Box Office Collection' from genre a
join earning b
on a.movie_id=b.movie_id
group by a.genre
order by [Box Office Collection] desc



---Which movies have the highest IMDb ratings?
select title ,  votesimdb from IMDB
order by VotesIMDB desc

---How do the voting patterns differ between male and female users?
select title ,rating,cvotesmale,votesm,cvotesfemale, votesf from imdb
order by cast(votesm as varchar(20)) desc,cast(votesf as varchar(20)) desc

--creating a view to use it later in power bi
create view votdiffingenders
 as select title ,rating,cvotesmale,votesm,cvotesfemale, votesf from imdb

 select * from votdiffingenders order by CAST(votesm as varchar(10)) desc , cast(votesf as varchar(10)) desc


 ---Is there a correlation between the movie budget and its domestic or worldwide earnings?
 select a.title , a.budget , b.domestic , b.worldwide from imdb a
join earning b
on a.movie_id=b.movie_id
order by a.budget desc, b.domestic desc , b.worldwide desc



--What is the average budget and earnings for each genre?
select a.genre , AVG(b.budget) as 'Average Budget' from genre a
join imdb b
on a.movie_id=b.movie_id
group by genre 
order by [Average Budget] desc

---which movies got flop at the boxoffice?
select a.Title ,a.budget , b.genre , c.Worldwide  from IMDB a
join genre b
on a.Movie_id=b.Movie_id
join earning c
on b.Movie_id=c.Movie_id
where a.Budget>c.Worldwide

---How do different age groups rate movies on average?
select title , VotesU18 , Votes1829 , Votes3044 , Votes45A from IMDB


---Are there differences in voting patterns between the U.S. and non-U.S. audiences?
select title , VotesUS as 'USA Ratings' , VotesnUS as 'Non -USA Ratings'  from IMDB 
order by cast(VotesUS as nvarchar(20)) desc , cast(VotesnUS as nvarchar(20)) desc
