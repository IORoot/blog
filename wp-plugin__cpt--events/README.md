# Event

Used to create my CPTs for LondonParkour.com. This is used to connect to google calendar

Contains:

1. Event

## Shortcode

```php

	[events_daily_three posts_per_page="10" order="ASC" distinct="true"]

		<div class="w-full md:w-1/2 pl-4 md:pl-10">
			{{title}}					
		</div>

	[/events_daily_three]

```

Note the `distinct` parameter, which is NOT a wp_query one. This is an added extra to
allow the distinct filter on the query.

All other parameters are appended / overwrite to the standard WP_Query arguments.