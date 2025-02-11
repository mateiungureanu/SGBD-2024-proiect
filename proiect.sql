drop sequence secventa_cinema;
drop sequence secventa_angajat;
drop sequence secventa_sala;
drop sequence secventa_film;
drop sequence secventa_achizitie;
drop table curata;
drop table bilete;
drop table achizitii;
drop table difuzari;
drop table filme;
drop table sali;
drop table ingrijitori;
drop table casieri;
drop table angajati;
drop table cinemauri;

create sequence secventa_cinema
start with 101;
create sequence secventa_angajat
start with 101;
create sequence secventa_sala
start with 101;
create sequence secventa_film
start with 101;
create sequence secventa_achizitie
start with 100001;

create table cinemauri (
    id_cinema number(3) default secventa_cinema.nextval primary key,
    nume_cinema varchar2(50) not null,
    oras varchar2(50) not null
);

create table angajati (
    id_angajat number(3) default secventa_angajat.nextval primary key,
    nume varchar2(20) not null,
    prenume varchar2(20) not null,
    email varchar2(50) unique,
    nr_telefon number (9) unique,
    salariu number(4) default 4000 not null,
    pct_comision number(1,1) default 0 not null,
    data_angajarii date not null,
    id_sef number(3),
    id_cinema number(3) not null references cinemauri(id_cinema) on delete cascade
);

create table casieri (
    id_angajat number(3) primary key references angajati(id_angajat) on delete cascade 
);

create table ingrijitori (
    id_angajat number(3) primary key references angajati(id_angajat) on delete cascade 
);

create table sali (
    id_sala number(3) default secventa_sala.nextval primary key,
    id_cinema number(3) not null references cinemauri(id_cinema) on delete cascade 
);

create table filme (
    id_film number(3) default secventa_film.nextval primary key,
    nume_film varchar2(100) not null,
    durata number(3),
    rating number(2,1),
    regizor varchar2(100),
    anul_lansarii number(4)
);

-- problema cu TIME, am pus varchar2(5) in loc
create table difuzari (
    data date,
    ora varchar2(5),
    id_sala number(3) references sali(id_sala) on delete cascade ,
    id_film number(3) references filme(id_film) on delete cascade ,
primary key (data, ora, id_sala, id_film)
);

create table achizitii (
    id_achizitie number(6) default secventa_achizitie.nextval primary key,
    email varchar2(100),
    nr_telefon number(9)
);

-- problema cu TIME, am pus varchar2(5) in loc
create table bilete (
    rand number(2),
    coloana number(2),
    data date,
    ora varchar2(5),
    id_sala number(3),
    id_film number(3),
    id_achizitie number(6) default secventa_achizitie.currval not null references achizitii(id_achizitie) on delete cascade ,
    id_angajat number(3) not null references casieri(id_angajat) on delete cascade ,
primary key (rand, coloana, data, ora, id_sala, id_film),
foreign key (data, ora, id_sala, id_film) references difuzari(data, ora, id_sala, id_film) on delete cascade 
);

create table curata (
    id_angajat number(3) references ingrijitori(id_angajat) on delete cascade ,
    id_sala number(3) references sali(id_sala) on delete cascade ,
primary key(id_angajat, id_sala)
);


insert into cinemauri (nume_cinema, oras)
values ('Chitcan', 'Bucuresti');
insert into cinemauri (nume_cinema, oras)
values ('Sobolan', 'Bucuresti');
insert into cinemauri (nume_cinema, oras)
values ('Soparlan', 'Bucuresti');
insert into cinemauri (nume_cinema, oras)
values ('Carcalac', 'Cluj');
insert into cinemauri (nume_cinema, oras)
values ('Popandau', 'Brasov');
insert into cinemauri (nume_cinema, oras)
values ('Harciog', 'Constanta');
insert into cinemauri (nume_cinema, oras)
values ('Mangusta', 'Timisoara');


insert into angajati (prenume, nume, email, nr_telefon, salariu, pct_comision, data_angajarii, id_cinema)
values ('PersonA', 'PersonAA', 'persona@gmail.com', 111111111, 7000, 0.7, '19-AUG-2017', 101);

insert into angajati (prenume, nume, nr_telefon, salariu, pct_comision, data_angajarii, id_sef, id_cinema)
values ('PersonB', 'PersonBB', 222222222, 5000, 0.5, '12-MAY-2018', 101, 101);
insert into casieri (id_angajat)
values (secventa_angajat.currval);
insert into angajati (prenume, nume, email, data_angajarii, id_sef, id_cinema)
values ('Alex', 'Alexandrescu', 'alexalexandrescu@yahoo.com', '20-JUN-2018', 102, 101);
insert into ingrijitori (id_angajat)
values (secventa_angajat.currval);
insert into angajati (prenume, nume, data_angajarii, id_sef, id_cinema)
values ('Bogdan', 'Bogdanescu', '3-JUL-2018', 102, 101);
insert into ingrijitori (id_angajat)
values (secventa_angajat.currval);

insert into angajati (prenume, nume, nr_telefon, salariu, pct_comision, data_angajarii, id_sef, id_cinema)
values ('PersonC', 'PersonCC', 333333333, 5000, 0.4, '7-JUL-2019', 101, 102);
insert into casieri (id_angajat)
values (secventa_angajat.currval);
insert into angajati (prenume, nume, data_angajarii, id_sef, id_cinema)
values ('Cornel', 'Corneleanu', '14-JUL-2019', 105, 102);
insert into ingrijitori (id_angajat)
values (secventa_angajat.currval);
insert into angajati (prenume, nume, email, data_angajarii, id_sef, id_cinema)
values ('David', 'Davidov', 'david_ov@gmail.com', '19-JUL-2019', 105, 102);
insert into ingrijitori (id_angajat)
values (secventa_angajat.currval);

insert into angajati (prenume, nume, nr_telefon, salariu, pct_comision, data_angajarii, id_sef, id_cinema)
values ('PersonD', 'PersonDD', 444444444, 5000, 0.3, '14-OCT-2019', 101, 103);
insert into casieri (id_angajat)
values (secventa_angajat.currval);
insert into angajati (prenume, nume, data_angajarii, id_sef, id_cinema)
values ('Eugen', 'Eugenescu', '27-OCT-2019', 108, 103);
insert into ingrijitori (id_angajat)
values (secventa_angajat.currval);
insert into angajati (prenume, nume, data_angajarii, id_sef, id_cinema)
values ('Florin', 'Florescu', '30-OCT-2019', 108, 103);
insert into ingrijitori (id_angajat)
values (secventa_angajat.currval);

insert into angajati (prenume, nume, email, nr_telefon, salariu, pct_comision, data_angajarii, id_sef, id_cinema)
values ('PersonE', 'PersonEE', 'persone@gmail.com', 555555555, 5000, 0.2, '2-AUG-2020', 101, 104);
insert into casieri (id_angajat)
values (secventa_angajat.currval);
insert into angajati (prenume, nume, email, data_angajarii, id_sef, id_cinema)
values ('Gigel', 'Gigelovici', 'gigelovici.gigel@gmail.com', '3-AUG-2020', 111, 104);
insert into ingrijitori (id_angajat)
values (secventa_angajat.currval);
insert into angajati (prenume, nume, data_angajarii, id_sef, id_cinema)
values ('Horia', 'Horienescu', '7-AUG-2020', 111, 104);
insert into ingrijitori (id_angajat)
values (secventa_angajat.currval);

insert into angajati (prenume, nume, nr_telefon, salariu, pct_comision, data_angajarii, id_sef, id_cinema)
values ('PersonF', 'PersonFF', 666666666, 5000, 0.1, '29-JUL-2020', 101, 105);
insert into casieri (id_angajat)
values (secventa_angajat.currval);
insert into angajati (prenume, nume, email, data_angajarii, id_sef, id_cinema)
values ('Ion', 'Ionescu', 'ion_ionescu@yahoo.com', '5-AUG-2020', 114, 105);
insert into ingrijitori (id_angajat)
values (secventa_angajat.currval);
insert into angajati (prenume, nume, data_angajarii, id_sef, id_cinema)
values ('Lucian', 'Lucescu', '14-AUG-2020', 114, 105);
insert into ingrijitori (id_angajat)
values (secventa_angajat.currval);

insert into angajati (prenume, nume, nr_telefon, salariu, pct_comision, data_angajarii, id_sef, id_cinema)
values ('PersonG', 'PersonGG', 777777777, 5000, 0.1, '1-JAN-2021', 101, 106);
insert into casieri (id_angajat)
values (secventa_angajat.currval);
insert into angajati (prenume, nume, data_angajarii, id_sef, id_cinema)
values ('Matei', 'Mateiescu', '10-JAN-2021', 117, 106);
insert into ingrijitori (id_angajat)
values (secventa_angajat.currval);
insert into angajati (prenume, nume, data_angajarii, id_sef, id_cinema)
values ('Nicolas', 'Nicolovici', '11-JAN-2021', 117, 106);
insert into ingrijitori (id_angajat)
values (secventa_angajat.currval);


insert into angajati (prenume, nume, nr_telefon, salariu, pct_comision, data_angajarii, id_sef, id_cinema)
values ('PersonH', 'PersonHH', 888888888, 5000, 0.1, '16-DEC-2021', 101, 107);
insert into casieri (id_angajat)
values (secventa_angajat.currval);
insert into angajati (prenume, nume, data_angajarii, id_sef, id_cinema)
values ('Octavian', 'Octavu', '21-DEC-2021', 120, 107);
insert into ingrijitori (id_angajat)
values (secventa_angajat.currval);
insert into angajati (prenume, nume, data_angajarii, id_sef, id_cinema)
values ('Radu', 'Raduleanu', '3-JAN-2022', 120, 107);
insert into ingrijitori (id_angajat)
values (secventa_angajat.currval);


insert into sali (id_cinema)
values (101);
insert into sali (id_cinema)
values (101);
insert into sali (id_cinema)
values (102);
insert into sali (id_cinema)
values (102);
insert into sali (id_cinema)
values (103);
insert into sali (id_cinema)
values (103);
insert into sali (id_cinema)
values (104);
insert into sali (id_cinema)
values (104);
insert into sali (id_cinema)
values (105);
insert into sali (id_cinema)
values (105);
insert into sali (id_cinema)
values (106);
insert into sali (id_cinema)
values (106);
insert into sali (id_cinema)
values (107);
insert into sali (id_cinema)
values (107);


insert into filme (nume_film, durata, rating, regizor, anul_lansarii)
values ('The Lord of the Rings: The Return of the King', 201, 9.0, 'Peter Jackson', 2003);
insert into filme (nume_film, durata, rating, regizor, anul_lansarii)
values ('Star Wars Episode III: Revenge of the Sith', 140, 7.6, 'George Lucas', 2005);
insert into filme (nume_film, durata, rating, regizor, anul_lansarii)
values ('The Dark Knight', 152, 9.0, 'Christopher Nolan', 2008);
insert into filme (nume_film, durata, rating, regizor, anul_lansarii)
values ('Oppenheimer', 180, 8.3, 'Christopher Nolan', 2023);
insert into filme (nume_film, durata, rating, regizor, anul_lansarii)
values ('Dune Part 2', 166, 8.6, 'Denis Villeneuve', 2024);


insert into difuzari (data, ora, id_sala, id_film)
values ('28-OCT-2018', '17:30', 101, 101);
insert into difuzari (data, ora, id_sala, id_film)
values ('30-NOV-2018', '20:30', 101, 102);
insert into difuzari (data, ora, id_sala, id_film)
values ('17-JUL-2019', '16:30', 103, 101);
insert into difuzari (data, ora, id_sala, id_film)
values ('3-SEP-2019', '18:30', 104, 102);
insert into difuzari (data, ora, id_sala, id_film)
values ('15-DEC-2019', '20:30', 102, 103);
insert into difuzari (data, ora, id_sala, id_film)
values ('27-AUG-2020', '17:45', 105, 101);
insert into difuzari (data, ora, id_sala, id_film)
values ('30-NOV-2020', '20:30', 106, 103);
insert into difuzari (data, ora, id_sala, id_film)
values ('24-JUL-2023', '16:15', 102, 104);
insert into difuzari (data, ora, id_sala, id_film)
values ('1-AUG-2023', '17:30', 107, 104);
insert into difuzari (data, ora, id_sala, id_film)
values ('1-MAR-2024', '19:30', 110, 105);
insert into difuzari (data, ora, id_sala, id_film)
values ('13-MAR-2024', '22:30', 104, 105);


insert into achizitii (email, nr_telefon)
values ('persona@gmail.com', 111111111);
insert into bilete (rand, coloana, data, ora, id_sala, id_film, id_angajat)
values (5, 3, '28-OCT-2018', '17:30', 101, 101, 102);
insert into bilete (rand, coloana, data, ora, id_sala, id_film, id_angajat)
values (5, 4, '28-OCT-2018', '17:30', 101, 101, 102);
insert into bilete (rand, coloana, data, ora, id_sala, id_film, id_angajat)
values (5, 5, '28-OCT-2018', '17:30', 101, 101, 102);
insert into bilete (rand, coloana, data, ora, id_sala, id_film, id_angajat)
values (5, 6, '28-OCT-2018', '17:30', 101, 101, 102);
insert into bilete (rand, coloana, data, ora, id_sala, id_film, id_angajat)
values (5, 7, '28-OCT-2018', '17:30', 101, 101, 102);
insert into bilete (rand, coloana, data, ora, id_sala, id_film, id_angajat)
values (5, 8, '28-OCT-2018', '17:30', 101, 101, 102);

insert into achizitii (email, nr_telefon)
values ('persona@gmail.com', 111111111);
insert into bilete (rand, coloana, data, ora, id_sala, id_film, id_angajat)
values (6, 5, '30-NOV-2018', '20:30', 101, 102, 102);
insert into bilete (rand, coloana, data, ora, id_sala, id_film, id_angajat)
values (6, 6, '30-NOV-2018', '20:30', 101, 102, 102);

insert into achizitii (email, nr_telefon)
values ('persona@gmail.com', 111111111);
insert into bilete (rand, coloana, data, ora, id_sala, id_film, id_angajat)
values (4, 4, '17-JUL-2019', '16:30', 103, 101, 105);
insert into bilete (rand, coloana, data, ora, id_sala, id_film, id_angajat)
values (4, 5, '17-JUL-2019', '16:30', 103, 101, 105);

insert into achizitii (email, nr_telefon)
values ('persone@gmail.com', 555555555);
insert into bilete (rand, coloana, data, ora, id_sala, id_film, id_angajat)
values (6, 5, '3-SEP-2019', '18:30', 104, 102, 105);

insert into achizitii (nr_telefon)
values (777777777);
insert into bilete (rand, coloana, data, ora, id_sala, id_film, id_angajat)
values (7, 4, '27-AUG-2020', '17:45', 105, 101, 108);
insert into bilete (rand, coloana, data, ora, id_sala, id_film, id_angajat)
values (7, 5, '27-AUG-2020', '17:45', 105, 101, 108);
insert into bilete (rand, coloana, data, ora, id_sala, id_film, id_angajat)
values (7, 6, '27-AUG-2020', '17:45', 105, 101, 108);

insert into achizitii (nr_telefon)
values (666666666);
insert into bilete (rand, coloana, data, ora, id_sala, id_film, id_angajat)
values (6, 5, '30-NOV-2020', '20:30', 106, 103, 108);
insert into bilete (rand, coloana, data, ora, id_sala, id_film, id_angajat)
values (6, 6, '30-NOV-2020', '20:30', 106, 103, 108);

insert into achizitii (email)
values ('alexalexandrescu@yahoo.com');
insert into bilete (rand, coloana, data, ora, id_sala, id_film, id_angajat)
values (3,5, '24-JUL-2023', '16:15', 102, 104, 102);

insert into achizitii (email)
values ('gigelovici.gigel@gmail.com');
insert into bilete (rand, coloana, data, ora, id_sala, id_film, id_angajat)
values (5, 5, '1-AUG-2023', '17:30', 107, 104, 111);
insert into bilete (rand, coloana, data, ora, id_sala, id_film, id_angajat)
values (5, 6, '1-AUG-2023', '17:30', 107, 104, 111);

insert into achizitii (email)
values ('ion_ionescu@yahoo.com');
insert into bilete (rand, coloana, data, ora, id_sala, id_film, id_angajat)
values (4, 5, '1-MAR-2024', '19:30', 110, 105, 114);
insert into bilete (rand, coloana, data, ora, id_sala, id_film, id_angajat)
values (4, 6, '1-MAR-2024', '19:30', 110, 105, 114);

insert into achizitii (email)
values ('david_ov@gmail.com');
insert into bilete (rand, coloana, data, ora, id_sala, id_film, id_angajat)
values (5, 5, '13-MAR-2024', '22:30', 104, 105, 105);


insert into curata (id_angajat, id_sala)
values (103, 101);
insert into curata (id_angajat, id_sala)
values (103, 102);
insert into curata (id_angajat, id_sala)
values (104, 101);
insert into curata (id_angajat, id_sala)
values (104, 102);

insert into curata (id_angajat, id_sala)
values (106, 103);
insert into curata (id_angajat, id_sala)
values (106, 104);
insert into curata (id_angajat, id_sala)
values (107, 103);
insert into curata (id_angajat, id_sala)
values (107, 104);

insert into curata (id_angajat, id_sala)
values (109, 105);
insert into curata (id_angajat, id_sala)
values (110, 106);

insert into curata (id_angajat, id_sala)
values (112, 107);
insert into curata (id_angajat, id_sala)
values (113, 108);

insert into curata (id_angajat, id_sala)
values (115, 109);
insert into curata (id_angajat, id_sala)
values (116, 110);

insert into curata (id_angajat, id_sala)
values (118, 111);
insert into curata (id_angajat, id_sala)
values (119, 112);

insert into curata (id_angajat, id_sala)
values (121, 113);
insert into curata (id_angajat, id_sala)
values (122, 114);

commit;

/*
6. Pentru top 3 filme cu cele mai multe difuzari, sa se afiseze numele, durata filmului reprezentata
de o litera (Animation, Short, Medium, Long, Extreme) si toate biletele cumparate pentru toate difuzarile
acelui film.
*/
create or replace procedure proiect_ex6 
is
    v_nr_filme number;
    type vector is varray(3) of number;
    v vector := vector();
    type tablou_imbricat is table of char(1);
    timbricat tablou_imbricat := tablou_imbricat('A', 'S', 'M', 'L', 'E');
    cursor c_filme is
        select nume_film, count(*)
        from filme join difuzari using(id_film)
        group by nume_film
        order by 2 desc, 1;
    v_nume_film filme.nume_film%type;
    v_durata filme.durata%type;
    v_litera char(1);
    v_top number;
    v_nr_bilete number;
    type tablou_indexat is table of number index by pls_integer;
    tindexat tablou_indexat;
    k number := 1;
begin
    select count(*)
    into v_nr_filme
    from filme;
    if v_nr_filme < 3 then
        raise_application_error(-20999, 'prea putine filme');
    end if;
    for i in 1..3 loop
        v.extend;
        v(i) := i;
    end loop;
    open c_filme;
    for i in v.first..v.last loop
        k := 1;
        fetch c_filme into v_nume_film, v_top;
        select durata 
        into v_durata
        from filme
        where nume_film = v_nume_film;
        v_litera := timbricat.first;
        if v_durata >= 90 then
            v_litera := timbricat.next(v_litera);
        end if;
        if v_durata >= 120 then
            v_litera := timbricat.next(v_litera);
        end if;
        if v_durata >= 150 then
            v_litera := timbricat.next(v_litera);
        end if;
        if v_durata >= 180 then
            v_litera := timbricat.next(v_litera);
        end if;
        dbms_output.put_line('(' || timbricat(v_litera) || ') ' || v_nume_film);
        select count(*)
        into v_nr_bilete
        from bilete;
        for j in 1..v_nr_bilete loop
            tindexat(j) := j;
        end loop;
        for j in (
            select *
            from bilete 
            where id_film = (
                select id_film
                from filme
                where nume_film = v_nume_film)
            order by data, ora, id_sala, rand, coloana
        ) loop
            dbms_output.put_line('   (' || tindexat(k) || ') ' || j.rand || ', ' || j.coloana 
            || ' | ' || j.id_sala || ' | ' || j.ora || ' | ' || j.data);
            k := k + 1;
        end loop;
    end loop;
    close c_filme;
end proiect_ex6;
/
execute proiect_ex6;

/*
7. Pentru fiecare angajat sa se mareasca cu 0.1 comisionul daca este luna aniversarii angajarii sale. 
Pentru fiecare cinema sa se afiseze numarul de angajati modificati.
*/
create or replace procedure proiect_ex7
is
    cursor cinema is
        select id_cinema, nume_cinema
        from cinemauri;
    cursor angajat(p_id_cinema cinemauri.id_cinema%type) is
        select id_angajat, nume, prenume, salariu, pct_comision, data_angajarii
        from angajati
        where id_cinema = p_id_cinema;
    v_id_cinema cinemauri.id_cinema%type;
    v_nume_cinema cinemauri.nume_cinema%type;
    v_id_angajat angajati.id_angajat%type;
    v_nume angajati.nume%type;
    v_prenume angajati.prenume%type;
    v_salariu angajati.salariu%type;
    v_comision angajati.pct_comision%type;
    v_data_angajarii angajati.data_angajarii%type;
    v_count number;
begin
    open cinema;
    loop
        fetch cinema into v_id_cinema, v_nume_cinema;
        exit when cinema%notfound;
        v_count := 0;
        dbms_output.put_line(v_id_cinema || '. ' || v_nume_cinema);
        open angajat(v_id_cinema);
        loop
            fetch angajat into v_id_angajat, v_nume, v_prenume, v_salariu, v_comision, v_data_angajarii;
            exit when angajat%notfound;
            if to_char(sysdate, 'Mon') = to_char(v_data_angajarii, 'Mon') and v_comision < 1 then
                v_comision := v_comision + 0.1;
                update angajati
                set pct_comision = v_comision
                where id_angajat = v_id_angajat;
                v_count := v_count + 1;
                dbms_output.put_line('   ' || v_id_angajat || '. ' || v_nume || ' ' || v_prenume
                || ' | ' || v_salariu || ' | ' || v_comision);
            end if;
        end loop;
        close angajat;
        dbms_output.put_line('modificari: ' || v_count);
    end loop;
    close cinema;
end proiect_ex7;
/
select * from angajati;
execute proiect_ex7;
rollback;

/*
8. Sa se obtina numele filmului, id-ul filmului, ora difuzarii si data difuzarii pentru difuzarea 
cu cele mai multe achizitii in care au fost cumparate doar 2 bilete.
*/
create or replace function proiect_ex8(
    v_id_film_out out difuzari.id_film%type,
    v_ora_out out difuzari.ora%type,
    v_data_out out difuzari.data%type
) return varchar2
is
    v_nume_film filme.nume_film%type;
begin
    select d.id_film, d.ora, d.data
    into v_id_film_out, v_ora_out, v_data_out
    from difuzari d join bilete b 
    on d.id_film = b.id_film 
    and d.id_sala = b.id_sala 
    and d.ora = b.ora 
    and d.data = b.data
    where b.id_achizitie in (
        select id_achizitie
        from bilete
        group by id_achizitie
        having count(*) = 2)
        --having count(*) = 9)
    group by d.id_film, d.ora, d.data
    having count(distinct b.id_achizitie) = (
        select max(nr_achizitii)
        from (
            select count(distinct b2.id_achizitie) as nr_achizitii
            from difuzari d2 join bilete b2 
            on d2.id_film = b2.id_film 
            and d2.id_sala = b2.id_sala 
            and d2.ora = b2.ora 
            and d2.data = b2.data
            where b2.id_achizitie in (
                select id_achizitie
                from bilete
                group by id_achizitie
                having count(*) = 2)
                --having count(*) = 9)
            group by d2.id_film, d2.id_sala, d2.ora, d2.data))
    order by d.data, d.ora, d.id_film;
    select nume_film
    into v_nume_film
    from filme
    where id_film = v_id_film_out;
    return v_nume_film;
exception
    when too_many_rows then
        dbms_output.put_line('Eroare: prea multe rezultate');
        v_id_film_out := null;
        v_ora_out := null;
        v_data_out := null;
        return null;
    when no_data_found then
        dbms_output.put_line('Eroare: nu au fost gasite rezultate');
        v_id_film_out := null;
        v_ora_out := null;
        v_data_out := null;
        return null;
    when others then
        dbms_output.put_line('Eroare: ' || sqlerrm);
        v_id_film_out := null;
        v_ora_out := null;
        v_data_out := null;
        return null;
end proiect_ex8;
/

declare
    v_id_film difuzari.id_film%type;
    v_ora difuzari.ora%type;
    v_data difuzari.data%type;
    v_nume_film varchar2(100);
begin
    insert into achizitii (email)
    values ('proiect_ex8@gmail.com');
    insert into bilete (rand, coloana, data, ora, id_sala, id_film, id_angajat)
    values (6, 5, '1-MAR-2024', '19:30', 110, 105, 114);
    insert into bilete (rand, coloana, data, ora, id_sala, id_film, id_angajat)
    values (6, 6, '1-MAR-2024', '19:30', 110, 105, 114);
    v_nume_film := proiect_ex8(v_id_film, v_ora, v_data);
    delete from achizitii
    where email = 'proiect_ex8@gmail.com';
    if v_nume_film is not null then
        dbms_output.put_line(v_nume_film || ' (' || v_id_film || ') | ' || v_ora || ' | ' || v_data);
    end if;
end;
/

/*
9. Sa se afiseze numele cinematografului, id-ul filmului, ora difuzarii si data difuzarii pentru 
difuzarile cu cele mai multe achizitii in care au fost cumparate x bilete, si sa se retina totalul.
*/
create or replace procedure proiect_ex9
    (x in pls_integer, total out pls_integer)
is
    invalid_input exception;  
    no_records_found exception;  
    pragma exception_init(invalid_input, -20001);
    pragma exception_init(no_records_found, -20002);
    cursor c is
        select c2.nume_cinema, d.id_film, d.ora, d.data
        from difuzari d join bilete b on d.id_film = b.id_film 
        and d.id_sala = b.id_sala 
        and d.ora = b.ora 
        and d.data = b.data
        join angajati a on b.id_angajat = a.id_angajat
        join cinemauri c2 on a.id_cinema = c2.id_cinema
        where b.id_achizitie in (
            select id_achizitie
            from bilete
            group by id_achizitie
            having count(*) = x)
        group by c2.nume_cinema, d.id_film, d.ora, d.data
        having count(distinct b.id_achizitie) = (
            select max(nr_achizitii)
            from (
                select count(distinct b2.id_achizitie) as nr_achizitii
                from difuzari d2 join bilete b2 on d2.id_film = b2.id_film 
                and d2.id_sala = b2.id_sala 
                and d2.ora = b2.ora 
                and d2.data = b2.data
                where b2.id_achizitie in (
                    select id_achizitie
                    from bilete
                    group by id_achizitie
                    having count(*) = x)
                group by d2.id_film, d2.id_sala, d2.ora, d2.data))
        order by 4, 3, 1, 2;
begin
    total := 0;
--declarare la limita posibila ca sa arat eroarea
    --total := power(2, 31)-1;
    if x <= 0 then
        raise invalid_input;
    end if;
    for i in c loop
        dbms_output.put_line(i.id_film || ' | ' || i.ora || ' | ' || i.data || ' | ' || i.nume_cinema);
        total := total + 1;
    end loop;
    if total = 0 then
        raise no_records_found;
    end if;
exception
    when invalid_input then
        dbms_output.put_line('Eroare: parametrul trebuie sa fie mai mare ca 0');
	total := null;
    when no_records_found then
        dbms_output.put_line('Eroare: nu exista achizitii cu ' || x || ' bilete pentru nicio difuzare');
	total := null;
    when others then
        dbms_output.put_line('Eroare: ' || sqlerrm);
	total := null;
end proiect_ex9;
/

declare
    total pls_integer;
begin
--aceleasi inserari ca la 8, pentru verificarea rezultatului (pt x=2)
    insert into achizitii (email)
    values ('proiect_ex8@gmail.com');
    insert into bilete (rand, coloana, data, ora, id_sala, id_film, id_angajat)
    values (6, 5, '1-MAR-2024', '19:30', 110, 105, 114);
    insert into bilete (rand, coloana, data, ora, id_sala, id_film, id_angajat)
    values (6, 6, '1-MAR-2024', '19:30', 110, 105, 114);
    proiect_ex9(2, total);
--executii speciale ca sa arat eroarea
    --proiect_ex9(9, total);
    --proiect_ex9(-1, total);
    delete from achizitii
    where email = 'proiect_ex8@gmail.com';
    dbms_output.put_line('Total: ' || total);
end;
/

/*
10. Sa se impiedice modificarea difuzarilor.
*/
create or replace trigger proiect_ex10
before update on difuzari
begin
    raise_application_error(-20001, 'Modificarea difuzarilor este interzisa.');
end;
/
update difuzari
set id_film = 999
where id_sala = 110;

/*
11. Sa se salveze difuzarile sterse intr-un tabel istoric_difuzari, impreuna cu numele filmului, 
id-ul cinemaului, numele cinemaului si orasul, si sa se impiedice adaugarea de difuzari noi care 
se suprapun cu difuzari existente. Sa se ia in calcul si jumatatea de ora de curatenie dintre difuzari.
*/
drop table istoric_difuzari;

create table istoric_difuzari (
    data date,
    ora varchar2(5),
    id_film number(3),
    nume_film varchar2(100),
    id_sala number(3),
    id_cinema number(3),
    nume_cinema varchar2(50),
    oras varchar2(50),
primary key (data, ora, id_film, id_sala)
);

create or replace trigger proiect_ex11
before insert or delete on difuzari
for each row
declare
    v_durata_noua number(3); 
    v_ora_noua timestamp;
    v_count number;
    v_nume_film varchar2(100);
    v_id_cinema number;
    v_nume_cinema varchar2(50);
    v_oras varchar2(50);
begin
    if inserting then
        select durata
        into v_durata_noua
        from filme
        where id_film = :new.id_film;
        v_ora_noua := to_timestamp(to_char(:new.data, 'DD-Mon-YY') || ' ' || :new.ora, 'DD-Mon-YY HH24:MI');
        select count(*)
        into v_count
        from difuzari d
        join filme f on d.id_film = f.id_film
        where d.id_sala = :new.id_sala
        and to_timestamp(to_char(d.data, 'DD-Mon-YY') || ' ' || d.ora, 'DD-Mon-YY HH24:MI') 
        + numtodsinterval(f.durata + 30, 'minute') > v_ora_noua
        and v_ora_noua + numtodsinterval(v_durata_noua + 30, 'minute') > to_timestamp(to_char(d.data, 'DD-Mon-YY') 
        || ' ' || d.ora, 'DD-Mon-YY HH24:MI');
        if v_count > 0 then
            raise_application_error(-20003, 'Difuzarea se suprapune cu o alta difuzare existenta in aceeasi sala.');
        end if;
    end if;
    if deleting then
        select nume_film 
        into v_nume_film
        from filme
        where id_film = :old.id_film;
        select c.id_cinema, nume_cinema, oras
        into v_id_cinema, v_nume_cinema, v_oras
        from sali s join cinemauri c on s.id_cinema = c.id_cinema
        where s.id_sala = :old.id_sala;
        insert into istoric_difuzari (data, ora, id_film, nume_film, id_sala, id_cinema, 
        nume_cinema, oras)
        values (:old.data, :old.ora, :old.id_film, v_nume_film, :old.id_sala, v_id_cinema, 
        v_nume_cinema, v_oras);
    end if;
end;
/
insert into difuzari (data, ora, id_sala, id_film)
values ('01-MAR-2024', '22:45', 110, 105);

insert into difuzari (data, ora, id_sala, id_film)
values ('01-MAR-2024', '22:46', 110, 105);

delete from difuzari
where data = '01-MAR-24'
and ora = '22:46';

select * from istoric_difuzari;

/*
12. Sa se salveze intr-un tabel logs crearile, modificarile si stergerile la nivel macro (tabele, 
proceduri etc.).
*/
drop trigger proiect_ex12;
drop table logs;

create table logs (
    user_id varchar2(30),
    nume_bd varchar2(50),
    eveniment varchar2(20),
    nume_obiect varchar2(30),
    data date
); 

create or replace trigger proiect_ex12
after create or alter or drop on schema
begin
    insert into logs
    values (sys.login_user, sys.database_name, sys.sysevent, sys.dictionary_obj_name, sysdate); 
end;
/
create table exemplu (id_exemplu number primary key);

alter table exemplu add ex number;

drop table exemplu;

select * from logs;

/*
13. Sa se afiseze numele filmului si durata filmului reprezentata de o litera (Animation, Short, 
Medium, Long, Extreme) pentru difuzarea cu cele mai multe bilete vandute, respectiv pentru cea 
cu cele mai putine bilete vandute, si sa se modifice corespunzator comisionul cu o zecime. In 
cazul maririi, se modifica doar pentru angajatii care au comisionul mai mic ca 1, mai mic ca 
seful companiei, si mai mic ca vechimea lor in ani * 0.1. In cazul micsorarii, se modifica doar 
pentru angajatii care au comisionul mai mare ca 0. Toti angajatii care au avut comisionul modificat 
vor fi afisati, impreuna cu totalul modificarii respective.
*/
create or replace package proiect_ex13 as
    function f1 return number;
    function f2 return number;
    procedure p1(v_id_sala in number);
    procedure p2(v_id_sala in number);
    type tablou_imbricat is table of char(1);
    type tablou_indexat is table of number index by pls_integer;
end proiect_ex13;
/

create or replace package body proiect_ex13 as
function f1 return number is
    v_nume_film filme.nume_film%type;
    v_id_sala sali.id_sala%type;
    v_durata filme.durata%type;
    v_litera char(1);
    timbricat tablou_imbricat := tablou_imbricat('A', 'S', 'M', 'L', 'E');
begin
    select max(nume_film), d.id_sala
    into v_nume_film, v_id_sala
    from filme f join difuzari d
    on f.id_film = d.id_film
    join bilete b 
    on d.id_film = b.id_film
    and d.id_sala = b.id_sala
    and d.ora = b.ora
    and d.data = b.data
    group by d.id_film, d.id_sala, d.ora, d.data
    having count(*) = (
        select max(nr_bilete)
        from (
            select count(*) as nr_bilete
            from bilete
            group by id_film, id_sala, ora, data));
    v_litera := timbricat.first;
    if v_durata >= 90 then
        v_litera := timbricat.next(v_litera);
    end if;
    if v_durata >= 120 then
        v_litera := timbricat.next(v_litera);
    end if;
    if v_durata >= 150 then
        v_litera := timbricat.next(v_litera);
    end if;
    if v_durata >= 180 then
        v_litera := timbricat.next(v_litera);
    end if;
    dbms_output.put_line('(' || timbricat(v_litera) || ') ' || v_nume_film);
    return v_id_sala;
exception
    when too_many_rows then
        dbms_output.put_line('Eroare in f1: prea multe rezultate');
        return null;
    when no_data_found then
        dbms_output.put_line('Eroare in f1: nu au fost gasite rezultate');
        return null;
    when others then
        dbms_output.put_line('Eroare in f1: ' || sqlerrm);
        return null;
end f1;

procedure p1(v_id_sala in number) is
    v_nr_angajati number;
    v_vechime number;
    v_comision_sef angajati.pct_comision%type;
    tindexat tablou_indexat;
    k number := 1;
begin
    select count(*)
    into v_nr_angajati
    from angajati;
    for i in 1..v_nr_angajati loop
        tindexat(i) := i;
    end loop;
    for i in (
        select *
        from angajati
        where id_cinema = (
            select id_cinema
            from sali
            where id_sala = v_id_sala))
    loop
        select (months_between(sysdate, data_angajarii) / 12)
        into v_vechime
        from angajati
        where id_angajat = i.id_angajat;
        select pct_comision
        into v_comision_sef
        from angajati
        where id_sef is null;
        if i.pct_comision < v_vechime * 0.1 and i.pct_comision < 1 and i.pct_comision < v_comision_sef then
            update angajati
            set pct_comision = pct_comision + 0.1
            where id_angajat = i.id_angajat;
            dbms_output.put_line(tindexat(k) || '. ' || i.nume || ' ' || i.prenume);
            k := k + 1;
        end if;
    end loop;
    k := k - 1;
    dbms_output.put_line('Total: ' || k);
exception
    when too_many_rows then
        dbms_output.put_line('Eroare in p1: prea multe rezultate');
    when no_data_found then
        dbms_output.put_line('Eroare in p1: nu au fost gasite rezultate');
    when others then
        dbms_output.put_line('Eroare in p1: ' || sqlerrm);
end p1;

function f2 return number is
    v_nume_film filme.nume_film%type;
    v_id_sala sali.id_sala%type;
    v_durata filme.durata%type;
    v_litera char(1);
    timbricat tablou_imbricat := tablou_imbricat('A', 'S', 'M', 'L', 'E');
begin
    select max(nume_film), d.id_sala
    into v_nume_film, v_id_sala
    from filme f join difuzari d
    on f.id_film = d.id_film
    join bilete b 
    on d.id_film = b.id_film
    and d.id_sala = b.id_sala
    and d.ora = b.ora
    and d.data = b.data
    group by d.id_film, d.id_sala, d.ora, d.data
    having count(*) = (
        select min(nr_bilete)
        from (
            select count(*) as nr_bilete
            from bilete
            group by id_film, id_sala, ora, data));
    v_litera := timbricat.first;
    if v_durata >= 90 then
        v_litera := timbricat.next(v_litera);
    end if;
    if v_durata >= 120 then
        v_litera := timbricat.next(v_litera);
    end if;
    if v_durata >= 150 then
        v_litera := timbricat.next(v_litera);
    end if;
    if v_durata >= 180 then
        v_litera := timbricat.next(v_litera);
    end if;
    dbms_output.put_line('(' || timbricat(v_litera) || ') ' || v_nume_film);
    return v_id_sala;
exception
    when too_many_rows then
        dbms_output.put_line('Eroare in f2: prea multe rezultate');
        return null;
    when no_data_found then
        dbms_output.put_line('Eroare in f2: nu au fost gasite rezultate');
        return null;
    when others then
        dbms_output.put_line('Eroare in f2: ' || sqlerrm);
        return null;
end f2;

procedure p2(v_id_sala in number) is
    v_nr_angajati number;
    tindexat tablou_indexat;
    k number := 1;
begin
    select count(*)
    into v_nr_angajati
    from angajati;
    for i in 1..v_nr_angajati loop
        tindexat(i) := i;
    end loop;
    for i in (
        select *
        from angajati
        where id_cinema = (
            select id_cinema
            from sali
            where id_sala = v_id_sala))
    loop
        if i.pct_comision > 0 then
            update angajati
            set pct_comision = pct_comision - 0.1
            where id_angajat = i.id_angajat;
            dbms_output.put_line(tindexat(k) || '. ' || i.nume || ' ' || i.prenume);
            k := k + 1;
        end if;
    end loop;
    k := k - 1;
    dbms_output.put_line('Total: ' || k);
exception
    when too_many_rows then
        dbms_output.put_line('Eroare in p2: prea multe rezultate');
    when no_data_found then
        dbms_output.put_line('Eroare in p2: nu au fost gasite rezultate');
    when others then
        dbms_output.put_line('Eroare in p2: ' || sqlerrm);
end p2;
end proiect_ex13;
/

declare
    v_id_sala number;
begin
    insert into achizitii (email)
    values ('proiect_ex13@gmail.com');
    insert into bilete (rand, coloana, data, ora, id_sala, id_film, id_angajat)
    values (3,6, '24-JUL-2023', '16:15', 102, 104, 102);
    insert into achizitii (email)
    values ('proiect_ex13@gmail.com');
    insert into bilete (rand, coloana, data, ora, id_sala, id_film, id_angajat)
    values (6, 6, '3-SEP-2019', '18:30', 104, 102, 105);
    v_id_sala := proiect_ex13.f1();
    if v_id_sala is not null then
        proiect_ex13.p1(v_id_sala);
    end if;
    v_id_sala := proiect_ex13.f2();
    if v_id_sala is not null then
        proiect_ex13.p2(v_id_sala);
    end if;
    delete from achizitii
    where email = 'proiect_ex13@gmail.com';
end;
/
rollback;