USE shoeshop;

-- Lista antalet produkter per kategori. Listningen ska innehålla kategori-namn och antalet produkter. 
SELECT kategori.namn,count(*) AS 'antal'  FROM  kategori JOIN produktkategori ON kategori.id = produktkategori.kategoriid
GROUP BY kategori.id ORDER BY 2;


-- Skapa en kundlista med den totala summanpengar som varje kundhar handlat för. Kundens för-och efternamn, samt det totala värdet som varje personhar shoppats för, skall visas.
SELECT förnamn, efternamn, sum(produkt.pris*beställningsrad.antal) AS 'summa' FROM kund JOIN beställning ON kund.id = beställning.kundid
JOIN beställningsrad ON beställning.id = beställningsrad.beställningsid
JOIN produkt ON beställningsrad.produktid = produkt.id
GROUP BY kund.id;


-- Vilka kunder har köpt svarta sandaleri storlek 38av märket Ecco? Lista deras namn. 
SELECT DISTINCT förnamn, efternamn FROM kund JOIN beställning ON kund.id = beställning.kundid
JOIN beställningsrad ON beställning.id = beställningsrad.beställningsid
JOIN produkt ON beställningsrad.produktid = produkt.id
JOIN produktkategori ON produkt.id = produktkategori.produktid
JOIN kategori ON produktkategori.kategoriid = kategori.id
WHERE produkt.märke = 'Ecco' AND produkt.storlek = 38 AND produkt.färg = 'Svart' AND kategori.namn = 'Sandaler';


-- Skriv ut en lista på det totala beställningsvärdetper ort där beställningsvärdet är större än 1000 kr.
-- Ortnamn och värde ska visas.(det måste finnasorter i databasen där det har handlats för mindre än 1000 kr för att visa att frågan är korrekt formulerad)
SELECT kund.ort, sum(produkt.pris*beställningsrad.antal) AS 'värde' FROM kund JOIN beställning ON kund.id = beställning.kundid
JOIN beställningsrad ON beställning.id = beställningsrad.beställningsid
JOIN produkt ON beställningsrad.produktid = produkt.id
GROUP BY kund.ort
HAVING sum(produkt.pris*beställningsrad.antal) > 1000;



-- Skapa en topp-5 lista av de mest sålda produkterna. 
SELECT produkt.id, produkt.märke, produkt.storlek, produkt.färg, produkt.pris, sum(beställningsrad.antal) AS 'antal'  FROM produkt JOIN beställningsrad ON produkt.id = beställningsrad.produktid
GROUP BY beställningsrad.produktid
ORDER BY sum(beställningsrad.antal) DESC
LIMIT 5;


-- Vilken månad hade duden största försäljningen?(det måste finnasdata som anger försäljning för mer än en månad i databasenför att visa att frågan är korrekt formulerad)
SELECT MONTH(datum) AS 'månad', sum(produkt.pris*beställningsrad.antal) AS 'summa' FROM beställning JOIN beställningsrad ON beställning.id = beställningsrad.beställningsid
JOIN produkt ON beställningsrad.produktid = produkt.id
GROUP BY MONTH(datum)
ORDER BY sum(produkt.pris*beställningsrad.antal) DESC
LIMIT 1;
