with 
internal as (
select 
	rgn.id as region_id, rgn.name as region_name, rgn.brand_id, rgn.region_level, rgn.structure_type, rgn.is_blocked, rgn.code as region_code, rgn.status as region_status, rgn.education_region_id,
	usr.id as user_id, usr.last_name || ' ' || usr.first_name as full_name,  usr.email, usr.mobile_number, usr.city
from regions as rgn
	left join user_post_brands as upb on rgn.id = upb.region_id
	left join user_posts as usp on usp.id = upb.user_post_id
	left join users as usr on usp.user_id = usr.id),
---internal_hrr выводит структру с вышестоящими регионами на три уровня выше
internal_hrr as (
select 
distinct inte.brand_id, inte.region_id,  inte.region_level, inte.structure_type, 
inte.user_id, inte.full_name,  inte.email, inte.mobile_number, inte.city, 
(CASE WHEN inte.region_level = 6 then l1.user_id ELSE NULL END) as "n1_user_id", 
(CASE WHEN inte.region_level = 6 THEN l1.full_name ELSE NULL END) as "n1_full_name",
(CASE inte.region_level 
 		WHEN 5 THEN l1.user_id
 		WHEN 6 THEN l2.user_id END) as "n2_user_id", 
 	(CASE inte.region_level 
 		WHEN 5 THEN l1.full_name
 		WHEN 6 THEN l2.full_name END) as "n2_full_name",
 	(CASE inte.region_level 
 		WHEN 4 THEN l1.user_id
 		WHEN 5 THEN l2.user_id
 		WHEN 6 THEN l3.user_id END) as "n3_user_id",
 	(CASE inte.region_level
 		WHEN 4 THEN l1.full_name
 		WHEN 5 THEN l2.full_name
 		WHEN 6 THEN l3.full_name END) as "n3_full_name",
 	(CASE inte.structure_type 
 		WHEN 1 THEN 'COM'
 		WHEN 2 THEN 'EDU' end) AS team,
 	brn.code
from internal as inte
left join region_hierarchies as rgh1 on rgh1.descendant_id = inte.region_id and rgh1.generations = 1
left join internal as l1 on  rgh1.ancestor_id = l1.region_id
left join region_hierarchies as rgh2 on rgh2.descendant_id = inte.region_id and rgh2.generations = 2
left join internal as l2 on  rgh2.ancestor_id = l2.region_id
left join region_hierarchies as rgh3 on rgh3.descendant_id = inte.region_id and rgh3.generations = 3
left join internal as l3 on  rgh3.ancestor_id = l3.region_id
left join brands AS brn ON inte.brand_id = brn.id )
---
select code, full_name, email, mobile_number, city, n1_full_name, n2_full_name, n3_full_name
from internal_hrr
where team in ('COM')