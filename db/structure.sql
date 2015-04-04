create schema office_climate;

create table office_climate.users (
  user_id serial primary key,
  name  varchar(255) not null
);

create table office_climate.places (
  place_id serial primary key,
  name  varchar(255) not null
);

create table office_climate.temperature_reports (
  temperature_report_id serial primary key,
  reporter_user_id integer not null references office_climate.users(user_id),
  place_id integer not null references office_climate.places(place_id),
  reported_at timestamp not null,
  factor integer not null
);
