---internal выводит структуру регионов сотурудников обучения сom и edu 
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
left join brands AS brn ON inte.brand_id = brn.id ),
---------------------------------------
region_srep as (
select 
	brn."name" as brand, brn.code,
	rgn.id as com_ter_id, 
	rgn.name as com_ter_name, 
	rgn.code as com_ter_code, 
	rgn.status as ter_status, 
	rgn1.id as com_reg_id, 
	rgn1.name as com_reg_name, 
	rgn1.code as com_reg_code, 
	rgn1.status as reg_status, 
	rgn2.id as com_mreg_id, 
	rgn2.name as com_mreg_name, 
	rgn2.code as com_mreg_code, 
	rgn2.status as mreg_status, 
	rgn1.education_region_id as edu_reg_id, 
	rgn1_edu."name" as edu_reg_name,
	rgn2_edu.id as edu_mreg_id, 
	rgn2_edu."name" as edu_mreg_name
from regions as rgn
	left join regions as rgn1 on rgn.parent_id = rgn1.id
	left join regions as rgn2 on rgn1.parent_id = rgn2.id
	left join regions as rgn1_edu on rgn1.education_region_id = rgn1_edu.id
	left join regions as rgn2_edu on rgn1_edu.parent_id = rgn2_edu.id
	left join brands as brn on rgn.brand_id = brn.id
where rgn.region_level = 6 and rgn.structure_type = 1)
---------------------------
----
---
---
select 
	extract(year from vrs.created_at) as year,
	extract(month from vrs.created_at) as month,
	extract(day from vrs.created_at) as day,
	vrs.event,
	--vrs.whodunnit as user_id,
	--vrs.base_item_id,
	int_h.full_name,
	(case int_h.region_level
		when 6 then 'SREP'
		when 5 then 'FLSM'
		when 4 then 'DR'
		else 'Other' end) as com_role,
	rgn_s.com_mreg_name,	
	count(vrs.id)
from versions as vrs
	left join internal_hrr as int_h on vrs.whodunnit = int_h.user_id::text
	left join region_srep as rgn_s on int_h.region_id = rgn_s.com_ter_id or int_h.region_id = rgn_s.com_reg_id
	--left join users as usr on vrs.whodunnit = usr.id::text
where vrs.item_type in ('YCustomer') --and vrs.whodunnit = '595'
group by extract(year from vrs.created_at), extract(month from vrs.created_at), extract(day from vrs.created_at), vrs.event , int_h.full_name, int_h.region_level, rgn_s.com_mreg_name
order by 1 desc, 2 desc , 5 desc


select 
	extract(year from bwc.created_at) as year,
	extract(month from bwc.created_at) as month,
	extract(day from bwc.created_at) as day,
	bwc.partner_name,
	count(bwc.id)
from y_customers as bwc
where left(bwc.code_bw, 1) = 'Y'
group by extract(year from bwc.created_at), extract(month from bwc.created_at), extract(day from bwc.created_at), 	bwc.partner_name
order by 1,2,3