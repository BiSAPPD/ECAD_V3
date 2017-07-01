with educater as(
select sme.educator_id, count(distinct sme.id) as count
from seminar_events as sme
group by sme.educator_id)
select usr.id, usr.login, usr.first_name, usr.last_name, usr.email, usr.mobile_number, usr.login_count,
usr.failed_login_count, to_char(usr.last_request_at,  'DD.MM.YYYY'),
(select edt."count" from educater as edt where usr.id = edt.educator_id ),
(select rgn."name" from regions as rgn left 
join user_posts as usp on rgn.user_post_id = usp.id  
where usp.user_id  = usr.id limit 1) as region,
(select edt."count" from educater as edt where usr.id = edt.educator_id ),
(select rgn.structure_type from regions as rgn left 
join user_posts as usp on rgn.user_post_id = usp.id  
where usp.user_id  = usr.id limit 1) as type,
usr.loreal_former_id, usr.matrix_former_id, usr.kerastase_former_id, usr.redken_former_id
from users as usr


--where usr.last_request_at is not null
