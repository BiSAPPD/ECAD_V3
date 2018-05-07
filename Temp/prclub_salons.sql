with
	salons_in_program as 
		(select distinct ssp.salon_id, ssp.
			from salons_special_programs ssp		
		where ssp.salon_id is not Null),
	salons_special_programs_list as
		(select salon_id as salon_id, spr.name as program_name, spp.accepted_at as accepted, brn.name as brand_name
			from salons_special_programs as spp
			left join special_programs as spr on spp.special_program_id = spr.id
			left join brands as brn on spr.brand_id = brn.id),
	salons_program_list as
		(select sln.salon_id, club_PY.program_name as club_PY, club_TY.program_name as club_TY, emotion_PY.program_name as emotion_PY, emotion_TY.program_name as emotion_TY,
		selectiv_PY.program_name as selectiv_PY, selectiv_TY.program_name as selectiv_TY 
			from salons as sln
			left join salons_special_programs_list as club_PY on sln.salon_id = club_PY.salon_id and club_PY.program_name in ('Салон Expert 2016', 'МБК 2016')
			left join salons_special_programs_list as club_TY on sln.salon_id = club_TY.salon_id and club_TY.program_name in ('Салон Expert 2017', 'МБК 2017')
			left join salons_special_programs_list as emotion_PY on sln.salon_id = emotion_PY.salon_id and emotion_PY.program_name like 'Salon Emotion % 2016'
			left join salons_special_programs_list as emotion_TY on sln.salon_id = emotion_TY.salon_id and emotion_TY.program_name like 'Salon Emotion % 2017'
			left join salons_special_programs_list as selectiv_PY on sln.salon_id = selectiv_PY.salon_id and selectiv_PY.program_name like 'Селективное Соглашение % 2016'
			left join salons_special_programs_list as selectiv_TY on sln.salon_id = selectiv_TY.salon_id and selectiv_TY.program_name like 'Селективное Соглашение % 2017'
		)  
select *
	from salons_program_list


select *
from special_programs
order by name
	
	
	