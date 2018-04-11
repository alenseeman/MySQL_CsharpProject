use is_ski;

-- full snowboard bez provjeraa
drop view if exists snowboardfull;
CREATE VIEW snowboardFull AS
    SELECT 
        so.IdOpreme,
        so.Naziv,
        CASE s.Pancerice
            WHEN 0 THEN 'Buce'
            WHEN 1 THEN 'Pancerice'
            ELSE 'Nepoznato'
        END AS Obuća,
        p.Naziv AS Proizvođač,
        st.Naziv AS Stil,
        so.Boja,
        so.Duzina AS Dužina,
        so.Cijena AS 'Cijena[KM]',
        so.GodinaProizvodnje as 'Godina proizvodnje'
    FROM
        snowboard s
            INNER JOIN
        stil st ON s.IdStila = st.IdStila
            INNER JOIN
        ski_oprema so ON s.IdOpreme = so.IdOpreme
            INNER JOIN
        proizvodjac p ON p.IdProizvodjaca = so.IdProizvodjaca;


-- snowboardfull -nedostupan=1
drop view snowboardDostupan;
CREATE VIEW snowboardDostupan AS
    SELECT 
        so.IdOpreme,
        so.Naziv,
        CASE s.Pancerice
            WHEN 0 THEN 'Buce'
            WHEN 1 THEN 'Pancerice'
            ELSE 'Nepoznato'
        END AS Obuća,
        p.Naziv AS Proizvođač,
        st.Naziv AS Stil,
        so.Boja,
        so.Duzina AS Dužina,
        so.Cijena as 'Cijena[KM]',
        so.GodinaProizvodnje AS 'Godina proizvodnje'
    FROM
        snowboard s
            INNER JOIN
        stil st ON s.IdStila = st.IdStila
            INNER JOIN
        ski_oprema so ON s.IdOpreme = so.IdOpreme
            INNER JOIN
        proizvodjac p ON p.IdProizvodjaca = so.IdProizvodjaca
    WHERE
        Nedostupan = 0;


-- svi snowboardi koji su danas na servisu
drop view if exists snowboardnaservisuDanas;
CREATE VIEW snowboardNaServisuDanas AS
    SELECT 
        *
    FROM
        snowboarddostupan
    WHERE
        IdOpreme IN (SELECT 
                IdOpreme
            FROM
                servisiranje
            WHERE
                DatumServisiranja = CURRENT_DATE());

-- skije full bez provjera
drop view if exists skijefull;
CREATE VIEW skijeFull AS
    SELECT 
        so.IdOpreme,
        so.Naziv,
        p.Naziv AS Proizvođač,
        so.GodinaProizvodnje AS 'Godina proizvodnje',
        so.Duzina AS Dužina,
        Boja,
        Cijena AS 'Cijena[KM]',
        Kilaza AS Kilaža
    FROM
        ski_oprema so
            NATURAL JOIN
        skije s
            INNER JOIN
        proizvodjac p ON p.IdProizvodjaca = so.IdProizvodjaca;

-- skije full - Nedostupan=1;
drop view if exists skijedostupne;
CREATE VIEW skijeDostupne AS
    SELECT 
        so.IdOpreme,
        so.Naziv,
        p.Naziv AS Proizvođač,
        so.GodinaProizvodnje AS 'Godina proizvodnje',
        so.Duzina AS Dužina,
        Boja,
        Cijena AS 'Cijena[KM]',
        Kilaza AS Kilaža
    FROM
        ski_oprema so
            NATURAL JOIN
        skije s
            INNER JOIN
        proizvodjac p ON p.IdProizvodjaca = so.IdProizvodjaca
    WHERE
        Nedostupan = 0;

-- skije koje su danas na servisu
drop view skijeNaServisuDanas;
CREATE VIEW skijeNaServisuDanas AS
    SELECT 
        *
    FROM
        skijedostupne
    WHERE
        IdOpreme IN (SELECT 
                IdOpreme
            FROM
                servisiranje
            WHERE
                DatumServisiranja = CURRENT_DATE());
	
    
drop view if exists iznajmljeneSkijeDanas;
create view iznajmljeneSkijeDanas as
select * from skijedostupne where 
IdOpreme in(
select IdOpreme from i_oprema where IdIznajmljivanja in(select IdIznajmljivanja from iznajmljivanje where IznajmljenoOdDatuma=current_date()  and DatumVracanja is null))

                
drop view if exists iznajmljeniSnowboardDanas;
create view iznajmljeniSnowboardDanas as
select * from snowboarddostupan where 
IdOpreme in(
select IdOpreme from i_oprema where IdIznajmljivanja in(select IdIznajmljivanja from iznajmljivanje where IznajmljenoOdDatuma=current_date()  and DatumVracanja is null))


-- Ski obuca full bez provjera
drop view if exists skiObucaFull;
CREATE VIEW skiObucaFull AS
    SELECT 
        so.IdObuce,
        so.Naziv,
        p.Naziv AS Proizvođač,
        Broj,
        Boja,
        Cijena AS 'Cijena[KM]',
        t.Naziv AS Vrsta
    FROM
        ski_obuca so
            INNER JOIN
        proizvodjac p ON so.IdProizvodjaca = p.IdProizvodjaca
            INNER JOIN
        tip t ON t.IdTipa = so.IdTipa;

-- buce 
drop view if exists bucedostupne;
CREATE VIEW buceDostupne AS
    SELECT 
        so.IdObuce,
        so.Naziv,
        p.Naziv AS Proizvođač,
        Broj,
        Boja,
        Cijena AS 'Cijena[KM]'
    FROM
        ski_obuca so
            INNER JOIN
        proizvodjac p ON so.IdProizvodjaca = p.IdProizvodjaca
            INNER JOIN
        tip t ON t.IdTipa = so.IdTipa
    WHERE
        t.Naziv = 'Buce' AND Nedostupan = 0;

 
drop view if exists pancericedostupne;
CREATE VIEW pancericedostupne AS
    SELECT 
        so.IdObuce,
        so.Naziv,
        p.Naziv AS Proizvođač,
        Broj,
        Boja,
        Cijena AS 'Cijena[KM]'
    FROM
        ski_obuca so
            INNER JOIN
        proizvodjac p ON so.IdProizvodjaca = p.IdProizvodjaca
            INNER JOIN
        tip t ON t.IdTipa = so.IdTipa
    WHERE
        t.Naziv = 'Pancerice' AND Nedostupan = 0;

 
 
-- sve iznajmljene pancerice za odredjeni dan
drop procedure if exists pancericeIznajmljene;
delimiter //
create procedure pancericeIznajmljene(in datum date)
begin
select * from pancericedostupne where IdObuce in(
select IdObuce from i_obuca where IdIznajmljivanja in(select IdIznajmljivanja from iznajmljivanje where IznajmljenoOdDatuma=datum and DatumVracanja is null)
);
end;
//


-- sve buce koje su iznajmljene za taj dan
drop procedure if exists buceIznajmljene;
delimiter //
create procedure buceIznajmljene(in datum date)
begin
select * from bucedostupne where IdObuce in(
select IdObuce from i_obuca where IdIznajmljivanja in(select IdIznajmljivanja from iznajmljivanje where IznajmljenoOdDatuma=datum and DatumVracanja is null)
);
end;
//

drop view dostupniSnowboardiRezervacijaDanas;
delimiter //
create view dostupniSnowboardiRezervacijaDanas as
select * from snowboardDostupan where IdOpreme in(
select IdOpreme from ski_oprema where IdOpreme not in(
select IdOpreme from r_oprema where IdRezervacije in(
select IdRezervacije from rezervacija where RezervisanoZaDan=current_date() and Otkazano=0) union
select IdOpreme from i_oprema where IdIznajmljivanja in(select IdIznajmljivanja from iznajmljivanje where IznajmljenoOdDatuma=current_date() and DatumVracanja is null)
union
select IdOpreme from servisiranje where DatumServisiranja=current_date()));


drop view dostupneSkijeRezervacijaDanas;
create view dostupneSkijeRezervacijaDanas as
select * from skijedostupne where IdOpreme in(
select IdOpreme from ski_oprema where IdOpreme not in(
select IdOpreme from r_oprema where IdRezervacije in(
select IdRezervacije from rezervacija where RezervisanoZaDan=current_date()  and Otkazano=0) union
select IdOpreme from i_oprema where IdIznajmljivanja in(select IdIznajmljivanja from iznajmljivanje where IznajmljenoOdDatuma=current_date()  and DatumVracanja is null)
union
select IdOpreme from servisiranje where DatumServisiranja=current_date() ));


-- vraca sve snowboarde koji nisu iznajmljeni ni rezervisani ni na servisu za odredjeni dan
drop procedure dostupniSnowboardiRezervacija;
delimiter //
create procedure dostupniSnowboardiRezervacija (in datum date)
begin
select * from snowboardDostupan where IdOpreme in(
select IdOpreme from ski_oprema where IdOpreme not in(
select IdOpreme from r_oprema where IdRezervacije in(
select IdRezervacije from rezervacija where RezervisanoZaDan=datum and Otkazano=0)
 union
select IdOpreme from i_oprema where IdIznajmljivanja in(
select IdIznajmljivanja from iznajmljivanje where IznajmljenoOdDatuma=datum and DatumVracanja is null)
union
select IdOpreme from servisiranje where DatumServisiranja=datum));
end;
end;
delimiter;



-- vraca sve skije koje nisu rezervisane ni iznajmljene ni na servisu za odredjeni dan
drop procedure if exists dostupneSkijeRezervacija;
delimiter //
create procedure dostupneSkijeRezervacija (in datum date)
begin
select * from skijedostupne where IdOpreme in(
select IdOpreme from ski_oprema where IdOpreme not in(
select IdOpreme from r_oprema where IdRezervacije in(
select IdRezervacije from rezervacija where RezervisanoZaDan=datum and Otkazano=0) union
select IdOpreme from i_oprema where IdIznajmljivanja in(
select IdIznajmljivanja from iznajmljivanje where IznajmljenoOdDatuma=datum and DatumVracanja is null)
union
select IdOpreme from servisiranje where DatumServisiranja=datum));
end;
delimiter;










-- vraca sve buce koje nisu rezervisane i nisu iznajmljene za danasnji dan
drop procedure if exists dostupneBuceRezervacija;
delimiter //
create procedure dostupneBuceRezervacija (in datum date)
begin
select * from bucedostupne where IdObuce in(
select IdObuce from ski_obuca where IdObuce not in(
select IdObuce from r_obuca where IdRezervacije in(
select IdRezervacije from rezervacija where RezervisanoZaDan=datum and Otkazano=0 ) union
select IdObuce from i_obuca where IdIznajmljivanja in(select IdIznajmljivanja from iznajmljivanje where IznajmljenoOdDatuma=datum and DatumVracanja is null)
));
end;
delimiter;



-- vraca mi sve pancerice koje nisu rezervisane , nisu iznajmljene za danasnji dan
drop procedure if exists dostupnePancericeRezervacija;
delimiter //
create procedure dostupnePancericeRezervacija (in datum date)
begin
select * from pancericedostupne where IdObuce in(
select IdObuce from ski_obuca where IdObuce not in(
select IdObuce from r_obuca where IdRezervacije in(
select IdRezervacije from rezervacija where RezervisanoZaDan=datum and Otkazano=0) union
select IdObuce from i_obuca where IdIznajmljivanja in(select IdIznajmljivanja from iznajmljivanje where IznajmljenoOdDatuma=datum and DatumVracanja is null)
));
end;
delimiter;


-- valja
drop procedure if exists dostupnaObucaRezervacija;
delimiter //
create procedure dostupnaObucaRezervacija (in datum date)
begin
select * from skiobucafull where IdObuce in(
select IdObuce from ski_obuca where IdObuce not in(
select IdObuce from r_obuca where IdRezervacije in(
select IdRezervacije from rezervacija where RezervisanoZaDan=datum and Otkazano=0) union
select IdObuce from i_obuca where IdIznajmljivanja in(
select IdIznajmljivanja from iznajmljivanje where IznajmljenoOdDatuma=datum and DatumVracanja is null)
));
end;
delimiter;

-- vraca listu svih buducih rezervacija odredjenog korisnika JMBG koja misu otkazana
drop procedure if exists listaSvihRezervacijaKorisnikBuducnost ;
delimiter //
create procedure listaSvihRezervacijaKorisnikBuducnost (in id char(13))
begin
select r.IdRezervacije,concat(o.Ime,' ',o.Prezime) as
 'Ime radnika',r.DatumRezervacije as 'Datum rezervacije',r.RezervisanoZaDan as 'Rezervisano za'
 from rezervacija r inner join osoba o on o.JMBG=r.JMBGZaposleni where r.JMBG=id and r.RezervisanoZaDan>=current_date() and r.Otkazano=0 ;
end;
delimiter;


-- vraca listu rezervisane opreme za datu Rezervaciju
drop procedure if exists listaRezervisaneOpremeId ;
delimiter //
create procedure listaRezervisaneOpremeId (in id int)
begin
select * from skiOpremaFull sof where sof.IdOpreme in( select IdOpreme from r_oprema where r_oprema.IdRezervacije=id);
end;
delimiter;

-- vraca listu opreme koja se nalazi u datom Iznajmljivanju
drop procedure if exists listaIznajmljeneOpremeId ;
delimiter //
create procedure listaIznajmljeneOpremeId  (in id int)
begin
select * from skiOpremaFull sof where sof.IdOpreme in( select IdOpreme from i_oprema where i_oprema.IdIznajmljivanja=id);
end//
delimiter ;


-- vraca listu rezervisane Obuce za datu Rezervaciju
drop procedure if exists listaRezervisaneObuceId ;
delimiter //
create procedure listaRezervisaneObuceId (in id int)
begin
select * from skiObucaFull sof where sof.IdObuce in( select IdObuce from r_obuca where r_obuca.IdRezervacije=id);
end//
delimiter ;

-- lista iznajmljene obuce u datoj Rezervaiciji
drop procedure if exists listaIznajmljeneObuceId ;
delimiter //
create procedure listaIznajmljeneObuceId  (in id int)
begin
select * from skiObucaFull sof where sof.IdObuce in( select IdObuce from i_obuca where i_obuca.IdIznajmljivanja=id);
end//
delimiter ;

-- vraca JMBG i za koji je dan rezervisana Rezervacija koja ima odredjeni ID
drop procedure if exists provjeraCijaJeRezervacija ;
delimiter //
create procedure provjeraCijaJeRezervacija(in id int)
begin
select JMBG,RezervisanoZaDan from rezervacija sof where sof.IdRezervacije=id;
end//
delimiter ;

-- sva rezervisana obuca(IdObuca i cijena) za taj idRezervacije
drop procedure if exists svaRezervisanaObucaId ;
delimiter //
create procedure svaRezervisanaObucaId(in id int)
begin
select IdObuce,Cijena from r_obuca sof where sof.IdRezervacije=id;
end//
delimiter ;

-- sva rezervisana oprema(IdOpreme i cijena) za taj idRezervacije
drop procedure if exists svaRezervisanaOpremaId ;
delimiter //
create procedure svaRezervisanaOpremaId(in id int)
begin
select IdOpreme,Cijena from r_oprema sof where sof.IdRezervacije=id;
end//
delimiter ;

-- sve rezervacije svih korisnika koja nisu otkazana
drop view if exists rezervacijeBuduceSvihKorisnika;
CREATE VIEW rezervacijeBuduceSvihKorisnika AS
    SELECT 
        r.IdRezervacije,
        CONCAT(o.Ime, ' ', o.Prezime) AS 'Ime osobe',
        r.RezervisanoZaDan AS 'Rezervisano za',
        r.DatumRezervacije AS 'Datum rezervacije'
    FROM
        rezervacija r
            INNER JOIN
        osoba o ON o.JMBG = r.JMBG
    WHERE
        r.RezervisanoZaDan >= CURRENT_DATE()
            AND r.Otkazano = 0;


-- sva danasnja iznajmljivanja koja nisu vracena
drop view if exists iznajmljivanjaDanasSvihKorisnika;
CREATE VIEW iznajmljivanjaDanasSvihKorisnika AS
    SELECT 
        r.IdIznajmljivanja,
        CONCAT(o.Ime, ' ', o.Prezime) AS 'Ime osobe',
        r.IznajmljenoOdDatuma AS 'Datum iznajmljivanja',
        CijenaIznajmljivanja AS 'Cijena iznajmljivanja[KM]'
    FROM
        iznajmljivanje r
            INNER JOIN
        osoba o ON o.JMBG = r.JMBG
    WHERE
        r.IznajmljenoOdDatuma = CURRENT_DATE()
            AND r.DatumVracanja IS NULL;

drop view if exists skiOpremaFull;
-- full ski oprema , presjek skija  i snowboarda
CREATE VIEW skiOpremaFull AS
    SELECT 
        so.IdOpreme, so.Naziv, p.Naziv AS Proizvođač, Boja, Cijena AS 'Cijena[KM]'
    FROM
        ski_oprema so
            INNER JOIN
        proizvodjac p ON so.IdProizvodjaca = p.IdProizvodjaca;

-- sva iznajmljivanja koja nisu vracena , datum nije bitan
drop view if exists iznajmljivanjaSvihKorisnikaKojaNisuVracena;
CREATE VIEW iznajmljivanjaSvihKorisnikaKojaNisuVracena AS
    SELECT 
        r.IdIznajmljivanja,
        CONCAT(o.Ime, ' ', o.Prezime) AS 'Ime osobe',
        r.IznajmljenoOdDatuma AS 'Datum iznajmljivanja',
        CijenaIznajmljivanja AS 'Cijena iznajmljivanja[KM]'
    FROM
        iznajmljivanje r
            INNER JOIN
        osoba o ON o.JMBG = r.JMBG
    WHERE
        r.DatumVracanja IS NULL;
        
        
-- TRIGERI        
drop trigger if exists unesiCijenuIObuca;
create trigger unesiCijenuIObuca before insert on i_obuca
for each row
set new.Cijena=(select si.Cijena from ski_obuca si where si.IdObuce=new.IdObuce);

drop trigger if exists unesiCijenuRObuca;
create trigger unesiCijenuRObuca before insert on r_obuca
for each row
set new.Cijena=(select si.Cijena from ski_obuca si where si.IdObuce=new.IdObuce);

drop trigger if exists unesiCijenuIOprema;
create trigger unesiCijenuIOprema before insert on i_oprema
for each row
set new.Cijena=(select si.Cijena from ski_oprema si where si.IdOpreme=new.IdOpreme);

drop trigger if exists unesiCijenuROprema;
create trigger unesiCijenuROprema before insert on r_oprema
for each row
set new.Cijena=(select si.Cijena from ski_oprema si where si.IdOpreme=new.IdOpreme);


drop trigger if exists UkupnaCijenaOprema;
create trigger UkupnaCijenaOprema before insert on i_oprema
for each row
update iznajmljivanje set CijenaIznajmljivanja=iznajmljivanje.CijenaIznajmljivanja+(select Cijena from ski_oprema where IdOpreme=new.IdOpreme) where IdIznajmljivanja=new.IdIznajmljivanja;

drop trigger if exists UkupnaCijenaObuca;
create trigger UkupnaCijenaObuca before insert on i_obuca
for each row
update iznajmljivanje set CijenaIznajmljivanja=iznajmljivanje.CijenaIznajmljivanja+(select Cijena from ski_obuca where IdObuce=new.IdObuce) where IdIznajmljivanja=new.IdIznajmljivanja;
