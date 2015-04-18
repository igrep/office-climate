/* user */
insert into office_climate.user (name) values ('igrep');
insert into office_climate.user (name) values ('hoge');
insert into office_climate.user (name) values ('foo');

/* place */
insert into office_climate.place (name) values ('Garden');
insert into office_climate.place (name) values ('Yagura');
insert into office_climate.place (name) values ('Lodge');
insert into office_climate.place (name) values ('Sansan');
insert into office_climate.place (name) values ('Europe');
insert into office_climate.place (name) values ('America');
insert into office_climate.place (name) values ('Asia');

/* temperature_report */
insert into office_climate.temperature_report (
  reporter_user_id,
  place_id,
  reported_at,
  factor
) values (
  1,
  1,
  NOW(),
  100
);
insert into office_climate.temperature_report (
  reporter_user_id,
  place_id,
  reported_at,
  factor
) values (
  1,
  2,
  NOW(),
  100
);
insert into office_climate.temperature_report (
  reporter_user_id,
  place_id,
  reported_at,
  factor
) values (
  1,
  3,
  NOW(),
  -100
);
