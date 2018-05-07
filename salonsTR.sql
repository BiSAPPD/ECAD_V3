with regs as (select 
	brd."code" as brand,
	rgn2.id as com_mreg_id, rgn2.name as com_mreg_name,
	rgn1.id as com_reg_id, rgn1.name as com_reg_name, 
	rgn.id as com_ter_id, rgn.name as com_ter_name, usr.last_name || ' '  || usr.first_name as srep
from regions as rgn
	left join regions as rgn1 on rgn.parent_id = rgn1.id
	left join regions as rgn2 on rgn1.parent_id = rgn2.id
	left join brands as brd on rgn.brand_id = brd.id
	left join user_post_brands as upb on rgn.id = upb.region_id
	left join user_posts as usp on usp.id = upb.user_post_id
	left join users as usr on usp.user_id = usr.id
where rgn.region_level = 6 and rgn.structure_type = 1 and
	brd.code = 'MX'), --фильтр марки на регионы
	
slns as (select s.id as sln_id, s.code_loreal, s."name" as sln_name,
		s.city as city, s.street || ' '  || s.house as address, st."name" as "type", s.is_network as network
	from salons as s
	left join salon_types as st on s.salon_type_id = st.id
	where s.deleted_at isnull),

turnover as (
	select (case ca.signature_id
		when 'C2' then 'LP'
		when 'C4' then 'KR'
		when 'C6' then 'MX'
		when 'C8' then 'RD'
		when 'CC' then 'CR'
		when 'CD' then 'DE' else 'ND' end) as brnd,
	y_customers.salon_id,
	SUM(case when ca.date_month = '01' and ca.date_year = '2017' then ca.value_partner::decimal else 0.0 end) as "prtn_01.2017",
	SUM(case when ca.date_month = '02' and ca.date_year = '2017' then ca.value_partner::decimal else 0.0 end) as "prtn_02.2017",
	SUM(case when ca.date_month = '03' and ca.date_year = '2017' then ca.value_partner::decimal else 0.0 end) as "prtn_03.2017",
	SUM(case when ca.date_month = '04' and ca.date_year = '2017' then ca.value_partner::decimal else 0.0 end) as "prtn_04.2017",
	SUM(case when ca.date_month = '05' and ca.date_year = '2017' then ca.value_partner::decimal else 0.0 end) as "prtn_05.2017",
	SUM(case when ca.date_month = '06' and ca.date_year = '2017' then ca.value_partner::decimal else 0.0 end) as "prtn_06.2017",
	SUM(case when ca.date_month = '07' and ca.date_year = '2017' then ca.value_partner::decimal else 0.0 end) as "prtn_07.2017",
	SUM(case when ca.date_month = '08' and ca.date_year = '2017' then ca.value_partner::decimal else 0.0 end) as "prtn_08.2017",
	SUM(case when ca.date_month = '09' and ca.date_year = '2017' then ca.value_partner::decimal else 0.0 end) as "prtn_09.2017",
	SUM(case when ca.date_month = '10' and ca.date_year = '2017' then ca.value_partner::decimal else 0.0 end) as "prtn_10.2017",
	SUM(case when ca.date_month = '11' and ca.date_year = '2017' then ca.value_partner::decimal else 0.0 end) as "prtn_11.2017",
	SUM(case when ca.date_month = '12' and ca.date_year = '2017' then ca.value_partner::decimal else 0.0 end) as "prtn_12.2017",
	SUM(case when ca.date_year = '2017' then ca.value_partner::decimal else 0.0 end) as "prtn_ttl_2017",
	SUM(case when ca.date_month = '01' and ca.date_year = '2016' then ca.value_partner::decimal else 0.0 end) as "prtn_01.2016",
	SUM(case when ca.date_month = '02' and ca.date_year = '2016' then ca.value_partner::decimal else 0.0 end) as "prtn_02.2016",
	SUM(case when ca.date_month = '03' and ca.date_year = '2016' then ca.value_partner::decimal else 0.0 end) as "prtn_03.2016",
	SUM(case when ca.date_month = '04' and ca.date_year = '2016' then ca.value_partner::decimal else 0.0 end) as "prtn_04.2016",
	SUM(case when ca.date_month = '05' and ca.date_year = '2016' then ca.value_partner::decimal else 0.0 end) as "prtn_05.2016",
	SUM(case when ca.date_month = '06' and ca.date_year = '2016' then ca.value_partner::decimal else 0.0 end) as "prtn_06.2016",
	SUM(case when ca.date_month = '07' and ca.date_year = '2016' then ca.value_partner::decimal else 0.0 end) as "prtn_07.2016",
	SUM(case when ca.date_month = '08' and ca.date_year = '2016' then ca.value_partner::decimal else 0.0 end) as "prtn_08.2016",
	SUM(case when ca.date_month = '09' and ca.date_year = '2016' then ca.value_partner::decimal else 0.0 end) as "prtn_09.2016",
	SUM(case when ca.date_month = '10' and ca.date_year = '2016' then ca.value_partner::decimal else 0.0 end) as "prtn_10.2016",
	SUM(case when ca.date_month = '11' and ca.date_year = '2016' then ca.value_partner::decimal else 0.0 end) as "prtn_11.2016",
	SUM(case when ca.date_month = '12' and ca.date_year = '2016' then ca.value_partner::decimal else 0.0 end) as "prtn_12.2016",
	SUM(case when ca.date_year = '2016' then ca.value_partner::decimal else 0.0 end) as "prtn_ttl_2016",
	SUM(case when ca.date_month = '01' and ca.date_year = '2017' then ca.value_loreal::decimal else 0.0 end) as "lor_01.2017",
	SUM(case when ca.date_month = '02' and ca.date_year = '2017' then ca.value_loreal::decimal else 0.0 end) as "lor_02.2017",
	SUM(case when ca.date_month = '03' and ca.date_year = '2017' then ca.value_loreal::decimal else 0.0 end) as "lor_03.2017",
	SUM(case when ca.date_month = '04' and ca.date_year = '2017' then ca.value_loreal::decimal else 0.0 end) as "lor_04.2017",
	SUM(case when ca.date_month = '05' and ca.date_year = '2017' then ca.value_loreal::decimal else 0.0 end) as "lor_05.2017",
	SUM(case when ca.date_month = '06' and ca.date_year = '2017' then ca.value_loreal::decimal else 0.0 end) as "lor_06.2017",
	SUM(case when ca.date_month = '07' and ca.date_year = '2017' then ca.value_loreal::decimal else 0.0 end) as "lor_07.2017",
	SUM(case when ca.date_month = '08' and ca.date_year = '2017' then ca.value_loreal::decimal else 0.0 end) as "lor_08.2017",
	SUM(case when ca.date_month = '09' and ca.date_year = '2017' then ca.value_loreal::decimal else 0.0 end) as "lor_09.2017",
	SUM(case when ca.date_month = '10' and ca.date_year = '2017' then ca.value_loreal::decimal else 0.0 end) as "lor_10.2017",
	SUM(case when ca.date_month = '11' and ca.date_year = '2017' then ca.value_loreal::decimal else 0.0 end) as "lor_11.2017",
	SUM(case when ca.date_month = '12' and ca.date_year = '2017' then ca.value_loreal::decimal else 0.0 end) as "lor_12.2017",
	SUM(case when ca.date_year = '2017' then ca.value_loreal::decimal else 0.0 end) as "lor_ttl_2017",
	SUM(case when ca.date_month = '01' and ca.date_year = '2016' then ca.value_loreal::decimal else 0.0 end) as "lor_01.2016",
	SUM(case when ca.date_month = '02' and ca.date_year = '2016' then ca.value_loreal::decimal else 0.0 end) as "lor_02.2016",
	SUM(case when ca.date_month = '03' and ca.date_year = '2016' then ca.value_loreal::decimal else 0.0 end) as "lor_03.2016",
	SUM(case when ca.date_month = '04' and ca.date_year = '2016' then ca.value_loreal::decimal else 0.0 end) as "lor_04.2016",
	SUM(case when ca.date_month = '05' and ca.date_year = '2016' then ca.value_loreal::decimal else 0.0 end) as "lor_05.2016",
	SUM(case when ca.date_month = '06' and ca.date_year = '2016' then ca.value_loreal::decimal else 0.0 end) as "lor_06.2016",
	SUM(case when ca.date_month = '07' and ca.date_year = '2016' then ca.value_loreal::decimal else 0.0 end) as "lor_07.2016",
	SUM(case when ca.date_month = '08' and ca.date_year = '2016' then ca.value_loreal::decimal else 0.0 end) as "lor_08.2016",
	SUM(case when ca.date_month = '09' and ca.date_year = '2016' then ca.value_loreal::decimal else 0.0 end) as "lor_09.2016",
	SUM(case when ca.date_month = '10' and ca.date_year = '2016' then ca.value_loreal::decimal else 0.0 end) as "lor_10.2016",
	SUM(case when ca.date_month = '11' and ca.date_year = '2016' then ca.value_loreal::decimal else 0.0 end) as "lor_11.2016",
	SUM(case when ca.date_month = '12' and ca.date_year = '2016' then ca.value_loreal::decimal else 0.0 end) as "lor_12.2016",
	SUM(case when ca.date_year = '2016' then ca.value_loreal::decimal else 0.0 end) as "lor_ttl_2016"
from y_customers
left join bw_y_turnovers as ca on y_customers.code_bw = ca.code_bw
where ca.signature_id = 'C6' --фильтр марки на оборот
group by 1,2
)

select slns.sln_id, slns.code_loreal,'' as code_erp,
	regs.com_mreg_name, regs.com_reg_name, regs.com_ter_name, srep,
	(case a.status when 1 then 'активный' when 2 then 'закрытый' when 0 then 'потенциальный' end) as dn,
	slns.sln_name, '' as law_name, slns.city, slns.address,
	'' as a1, '' as a2, '' as a3, '' as a4,
	(case slns.network when true then 'сетевой' else '' end) as is_chain,
	slns."type",
	'' as chain_name, '' as chain_code, '' as chain_type,
	'' as a5,
	'' as min_price,'' as min_brand, '' as max_price, '' as max_brand, '' as workplaces, '' as hd_cnt,
	slns.sln_id as old_ea_id, '' as new_ea_id,
	'' as AE, '' as AF,
	'' as visit_orders, '' as phone_orders, '' as visits,
	'' as AJ, '' as AK, '' as AL,
	'' as AM, '' as AN,
	'' as emotion_py, '' as empotion_ty,
	'' as AQ, '' as AR,'' as "AS",'' as "AT",'' as AU,'' as AV,'' as AW,'' as AX,'' as AY,'' as AZ,'' as BA,'' as BB,'' as BC,'' as BD,'' as BE,'' as BF,'' as BG,'' as BH,'' as BI,'' as BJ,'' as BK,
	(case extract(month from a.open_date::timestamp at time zone 'UTC')
	when 1 then 'январь'
	when 2 then 'февраль'
	when 3 then 'март'
	when 4 then 'апрель'
	when 5 then 'май'
	when 6 then 'июнь'
	when 7 then 'июль'
	when 8 then 'август'
	when 9 then 'сентябрь'
	when 10 then 'октябрь'
	when 11 then 'ноябрь'
	when 12 then 'декабрь' end) as open_month,
	extract(year from a.open_date::timestamp at time zone 'UTC') as open_year,
	"prtn_01.2017", "prtn_02.2017", "prtn_03.2017", "prtn_04.2017", "prtn_05.2017", "prtn_06.2017", "prtn_07.2017", "prtn_08.2017", "prtn_09.2017", "prtn_10.2017", "prtn_11.2017", "prtn_12.2017", "prtn_ttl_2017",
	"prtn_01.2016", "prtn_02.2016", "prtn_03.2016", "prtn_04.2016", "prtn_05.2016", "prtn_06.2016", "prtn_07.2016", "prtn_08.2016", "prtn_09.2016", "prtn_10.2016", "prtn_11.2016", "prtn_12.2016", "prtn_ttl_2016",
	'' as evol,
	"lor_01.2017", "lor_02.2017", "lor_03.2017", "lor_04.2017", "lor_05.2017", "lor_06.2017", "lor_07.2017", "lor_08.2017", "lor_09.2017", "lor_10.2017", "lor_11.2017", "lor_12.2017", "lor_ttl_2017",
	"lor_01.2016", "lor_02.2016", "lor_03.2016", "lor_04.2016", "lor_05.2016", "lor_06.2016", "lor_07.2016", "lor_08.2016", "lor_09.2016", "lor_10.2016", "lor_11.2016", "lor_12.2016", "lor_ttl_2016",
	'' as sale, '' as ratio, '' as subdistr,
	'' as DR,'' as DS,'' as DT,'' as DU,'' as DV,'' as DW,'' as DX,'' as DY,'' as clos, '' as cm, '' as close_year, '' as "comment", regs.brand as br
from regions_salons as a
inner join regs on a.region_id = regs.com_ter_id
inner join slns on a.salon_id = slns.sln_id
left join turnover on slns.sln_id = turnover.salon_id and regs.brand = turnover.brnd
where brand = 'MX'

select (case ca.signature_id
		when 'C2' then 'LP'
		when 'C4' then 'KR'
		when 'C6' then 'MX'
		when 'C8' then 'RD'
		when 'CC' then 'CR'
		when 'CD' then 'DE' else 'ND' end) as brnd, 
	cust.partner_id, ca.code_bw, cust.code_partner_erp,
	SUM(case when ca.date_month = '01' and ca.date_year = '2017' then ca.value_partner::decimal else 0.0 end) as "prtn_01.2017",
	SUM(case when ca.date_month = '02' and ca.date_year = '2017' then ca.value_partner::decimal else 0.0 end) as "prtn_02.2017",
	SUM(case when ca.date_month = '03' and ca.date_year = '2017' then ca.value_partner::decimal else 0.0 end) as "prtn_03.2017",
	SUM(case when ca.date_month = '04' and ca.date_year = '2017' then ca.value_partner::decimal else 0.0 end) as "prtn_04.2017",
	SUM(case when ca.date_month = '05' and ca.date_year = '2017' then ca.value_partner::decimal else 0.0 end) as "prtn_05.2017",
	SUM(case when ca.date_month = '06' and ca.date_year = '2017' then ca.value_partner::decimal else 0.0 end) as "prtn_06.2017",
	SUM(case when ca.date_month = '07' and ca.date_year = '2017' then ca.value_partner::decimal else 0.0 end) as "prtn_07.2017",
	SUM(case when ca.date_month = '08' and ca.date_year = '2017' then ca.value_partner::decimal else 0.0 end) as "prtn_08.2017",
	SUM(case when ca.date_month = '09' and ca.date_year = '2017' then ca.value_partner::decimal else 0.0 end) as "prtn_09.2017",
	SUM(case when ca.date_month = '10' and ca.date_year = '2017' then ca.value_partner::decimal else 0.0 end) as "prtn_10.2017",
	SUM(case when ca.date_month = '11' and ca.date_year = '2017' then ca.value_partner::decimal else 0.0 end) as "prtn_11.2017",
	SUM(case when ca.date_month = '12' and ca.date_year = '2017' then ca.value_partner::decimal else 0.0 end) as "prtn_12.2017",
	SUM(case when ca.date_year = '2017' then ca.value_partner::decimal else 0.0 end) as "prtn_ttl_2017",
	SUM(case when ca.date_month = '01' and ca.date_year = '2016' then ca.value_partner::decimal else 0.0 end) as "prtn_01.2016",
	SUM(case when ca.date_month = '02' and ca.date_year = '2016' then ca.value_partner::decimal else 0.0 end) as "prtn_02.2016",
	SUM(case when ca.date_month = '03' and ca.date_year = '2016' then ca.value_partner::decimal else 0.0 end) as "prtn_03.2016",
	SUM(case when ca.date_month = '04' and ca.date_year = '2016' then ca.value_partner::decimal else 0.0 end) as "prtn_04.2016",
	SUM(case when ca.date_month = '05' and ca.date_year = '2016' then ca.value_partner::decimal else 0.0 end) as "prtn_05.2016",
	SUM(case when ca.date_month = '06' and ca.date_year = '2016' then ca.value_partner::decimal else 0.0 end) as "prtn_06.2016",
	SUM(case when ca.date_month = '07' and ca.date_year = '2016' then ca.value_partner::decimal else 0.0 end) as "prtn_07.2016",
	SUM(case when ca.date_month = '08' and ca.date_year = '2016' then ca.value_partner::decimal else 0.0 end) as "prtn_08.2016",
	SUM(case when ca.date_month = '09' and ca.date_year = '2016' then ca.value_partner::decimal else 0.0 end) as "prtn_09.2016",
	SUM(case when ca.date_month = '10' and ca.date_year = '2016' then ca.value_partner::decimal else 0.0 end) as "prtn_10.2016",
	SUM(case when ca.date_month = '11' and ca.date_year = '2016' then ca.value_partner::decimal else 0.0 end) as "prtn_11.2016",
	SUM(case when ca.date_month = '12' and ca.date_year = '2016' then ca.value_partner::decimal else 0.0 end) as "prtn_12.2016",
	SUM(case when ca.date_year = '2016' then ca.value_partner::decimal else 0.0 end) as "prtn_ttl_2016",
	SUM(case when ca.date_month = '01' and ca.date_year = '2017' then ca.value_loreal::decimal else 0.0 end) as "lor_01.2017",
	SUM(case when ca.date_month = '02' and ca.date_year = '2017' then ca.value_loreal::decimal else 0.0 end) as "lor_02.2017",
	SUM(case when ca.date_month = '03' and ca.date_year = '2017' then ca.value_loreal::decimal else 0.0 end) as "lor_03.2017",
	SUM(case when ca.date_month = '04' and ca.date_year = '2017' then ca.value_loreal::decimal else 0.0 end) as "lor_04.2017",
	SUM(case when ca.date_month = '05' and ca.date_year = '2017' then ca.value_loreal::decimal else 0.0 end) as "lor_05.2017",
	SUM(case when ca.date_month = '06' and ca.date_year = '2017' then ca.value_loreal::decimal else 0.0 end) as "lor_06.2017",
	SUM(case when ca.date_month = '07' and ca.date_year = '2017' then ca.value_loreal::decimal else 0.0 end) as "lor_07.2017",
	SUM(case when ca.date_month = '08' and ca.date_year = '2017' then ca.value_loreal::decimal else 0.0 end) as "lor_08.2017",
	SUM(case when ca.date_month = '09' and ca.date_year = '2017' then ca.value_loreal::decimal else 0.0 end) as "lor_09.2017",
	SUM(case when ca.date_month = '10' and ca.date_year = '2017' then ca.value_loreal::decimal else 0.0 end) as "lor_10.2017",
	SUM(case when ca.date_month = '11' and ca.date_year = '2017' then ca.value_loreal::decimal else 0.0 end) as "lor_11.2017",
	SUM(case when ca.date_month = '12' and ca.date_year = '2017' then ca.value_loreal::decimal else 0.0 end) as "lor_12.2017",
	SUM(case when ca.date_year = '2017' then ca.value_loreal::decimal else 0.0 end) as "lor_ttl_2017",
	SUM(case when ca.date_month = '01' and ca.date_year = '2016' then ca.value_loreal::decimal else 0.0 end) as "lor_01.2016",
	SUM(case when ca.date_month = '02' and ca.date_year = '2016' then ca.value_loreal::decimal else 0.0 end) as "lor_02.2016",
	SUM(case when ca.date_month = '03' and ca.date_year = '2016' then ca.value_loreal::decimal else 0.0 end) as "lor_03.2016",
	SUM(case when ca.date_month = '04' and ca.date_year = '2016' then ca.value_loreal::decimal else 0.0 end) as "lor_04.2016",
	SUM(case when ca.date_month = '05' and ca.date_year = '2016' then ca.value_loreal::decimal else 0.0 end) as "lor_05.2016",
	SUM(case when ca.date_month = '06' and ca.date_year = '2016' then ca.value_loreal::decimal else 0.0 end) as "lor_06.2016",
	SUM(case when ca.date_month = '07' and ca.date_year = '2016' then ca.value_loreal::decimal else 0.0 end) as "lor_07.2016",
	SUM(case when ca.date_month = '08' and ca.date_year = '2016' then ca.value_loreal::decimal else 0.0 end) as "lor_08.2016",
	SUM(case when ca.date_month = '09' and ca.date_year = '2016' then ca.value_loreal::decimal else 0.0 end) as "lor_09.2016",
	SUM(case when ca.date_month = '10' and ca.date_year = '2016' then ca.value_loreal::decimal else 0.0 end) as "lor_10.2016",
	SUM(case when ca.date_month = '11' and ca.date_year = '2016' then ca.value_loreal::decimal else 0.0 end) as "lor_11.2016",
	SUM(case when ca.date_month = '12' and ca.date_year = '2016' then ca.value_loreal::decimal else 0.0 end) as "lor_12.2016",
	SUM(case when ca.date_year = '2016' then ca.value_loreal::decimal else 0.0 end) as "lor_ttl_2016"
from bw_y_turnovers as ca
left join bw_y_customers as cust on ca.code_bw = cust.code_bw
--left join y_customers on ca.code_bw = y_customers.code_bw
where ca.signature_id = 'C6' and ca.code_bw not in (select code_bw from y_customers) --фильтр марки на оборот
group by 1,2,3,4
