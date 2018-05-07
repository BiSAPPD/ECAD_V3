select *
from seminar_events as sme
left join seminars as smr on sme.seminar_id =smr.id
left join training_centers as trc on sme.studio_id = trc.id
left join salons as sln on sme.salon_id =sln.id
left join brands as brn on smr.brand_id = brn.id
left join users as edu on sme.educator_id = edu.id
left join seminar_event_types as smret on sme.seminar_event_type_id = smret.id 
left join participations as prt on sme.id = prt.seminar_event_id
left join users as prtu on prt.user_id = prtu.id
left join users as prtru on prt.recorded_user_id = prtru.id
where 