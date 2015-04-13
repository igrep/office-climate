create schema office_climate;

create table office_climate.user (
  user_id serial primary key,
  name  varchar(255) not null
);

create table office_climate.place (
  place_id serial primary key,
  name  varchar(255) not null
);

create table office_climate.temperature_report (
  temperature_report_id serial primary key,
  reporter_user_id integer not null references office_climate.user(user_id),
  place_id integer not null references office_climate.place(place_id),
  reported_at timestamp not null,
  factor integer not null
);
