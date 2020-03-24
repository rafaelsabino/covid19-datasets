(
	[
		
		"location_key",
		"location_type",
		"location_label",
		
		"country_code",
		"country",
		"province",
		"location_lat",
		"location_long",
		
		"date",
		"day_index_1",
		"day_index_10",
		"day_index_100",
		"day_index_1000",
		"day_index_10000",
		
		"absolute_confirmed",
		"absolute_deaths",
		"absolute_recovered",
		"absolute_infected",
		
		"relative_confirmed",
		"relative_deaths",
		"relative_recovered",
		"relative_infected",
		
		"delta_confirmed",
		"delta_deaths",
		"delta_recovered",
		"delta_infected",
		
		"deltapct_confirmed",
		"deltapct_deaths",
		"deltapct_recovered",
		"deltapct_infected",
		
		"location_key_original",
		"country_original",
		"province_original"
		
	]
	| join ("\t")
	
) , (
	
	.[]
	| .location.latlong = (.location.province_latlong // .location.country_latlong)
	| (
		[
		
			.location.key,
			.location.type,
			.location.label,
			.location.country_code,
			.location.country,
			.location.province,
			.location.latlong[0],
			.location.latlong[1],
			
			.date.date,
			.day_index_1,
			.day_index_10,
			.day_index_100,
			.day_index_1000,
			.day_index_10000
			
		] + [
			
			.values
			| (.absolute, .relative, .delta, .delta_pct)
			| (.confirmed, .deaths, .recovered, .infected)
			
		] + [
			
			.location.key_original,
			.location.country_original,
			.location.province_original
			
		]
	)
	| map (if (. != null) then tostring else "" end)
	| join ("\t")
	
)
