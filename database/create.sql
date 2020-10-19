create schema namegator;

create table namegator.item(
    id serial,
    type text not null,
    description text not null
);

insert into namegator.item(type, description)values('prefix', 'flight');
insert into namegator.item(type, description)values('prefix', 'jet');
insert into namegator.item(type, description)values('prefix', 'air');
insert into namegator.item(type, description)values('suffix', 'hub');
insert into namegator.item(type, description)values('suffix', 'station');
insert into namegator.item(type, description)values('suffix', 'mart');
