ALTER SEQUENCE office_climate.user_user_id_seq RESTART WITH 1;
ALTER SEQUENCE office_climate.place_place_id_seq RESTART WITH 1;
ALTER SEQUENCE office_climate.temperature_report_temperature_report_id_seq RESTART WITH 1;

delete from office_climate.temperature_report;
delete from office_climate.user;
delete from office_climate.place;
