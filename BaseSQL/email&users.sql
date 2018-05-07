with brand_users as
	(select usr.id, 
		(case brn.code 
			when 'MX' then 'MX'
			when 'LP' then 'LP'
			when 'RD' then 'RD'
			when 'KR' then 'KR' 
			when 'DE' then 'DE' 
			when 'CR' then 'CR' 
			when 'ES' then 'ES' 
		else 
			(case when usr.loreal_former_id is not null then 'LP' else
				(case when usr.matrix_former_id is not null then 'MX' else
					(case when usr.kerastase_former_id is not null then 'KR' else
						(case when usr.redken_former_id is not null then 'RD' end) end) end) end) end) as brand
		from users as usr
			left join users_brands as usrb on usr.id = usrb.user_id
			left join brands as brn on usrb.brand_id = brn.id
						)
select 
	brn.brand,
	 count(distinct usr.id) as users, count(distinct usr.email) as user_email, count(distinct usr.mobile_number) as user_mobile
from users as usr
left join brand_users as brn on usr.id = brn.id
where brn.brand is not null
group by brn.brand 
order by 2 desc
--limit 1000