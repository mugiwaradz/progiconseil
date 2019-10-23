SELECT histo_factures.numfac,
       histo_factures.datefac,
       TO_CHAR(datefac, 'MONTH', 'nls_date_language= FRENCH')  AS mois,
       TO_CHAR(datefac, 'RRRR')                                AS annee,
       histo_factures.numligne,
       histo_factures.typedoc,
       histo_factures.codecli,
       histo_factures.rep,
       histo_factures.totalht,
       histo_factures.totaltva,
       histo_factures.totalttc,
       histo_factures.numbl,
       histo_factures.numligne_bl,
       histo_factures.refart,
       DECODE(typedoc, 'FC', qte, - qte)                       AS quantite,
       DECODE(typedoc, 'FC', volume, - volume)                 AS vol,
       histo_factures.pu_brut,
       histo_factures.pu_net,
       histo_factures.fam1,
       histo_factures.fam2,
       histo_factures.fam3,
       histo_factures.famart,
       DECODE(typedoc, 'FC', total_ht_ligne, - total_ht_ligne) AS ca,
       articles.artgen,
       articles.artlib,
       zfamcli.famille3_0,
       zfamcli.famille4_0,
       zfamcli.famille5_0
FROM ( ( histo_factures left
    JOIN articles ON histo_factures.refart = articles.artnum ) left
    JOIN bpcustomer ON histo_factures.codecli = bpcustomer.bpcnum_0 )
         left JOIN zfamcli ON bpcustomer.bpcnum_0 = zfamcli.code_0
WHERE histo_factures.datefac BETWEEN TO_DATE('01/01/2019', 'DD/MM/YYYY') AND TO_DATE('31/08/2019', 'DD/MM/YYYY')
  AND histo_factures.typedoc <> 'FP'
  AND bpcustomer.tsccod_1 = '243'
UNION ALL
SELECT zca_heimburger.numfac,
       zca_heimburger.datefac,
       TO_CHAR(datefac, 'MONTH', 'nls_date_language= FRENCH') AS mois,
       TO_CHAR(datefac, 'RRRR')                               AS annee,
       zca_heimburger.numligne,
       zca_heimburger.typedoc,
       zca_heimburger.codecli,
       zca_heimburger.rep,
       zca_heimburger.totalht,
       zca_heimburger.totaltva,
       zca_heimburger.totalttc,
       zca_heimburger.numbl,
       zca_heimburger.numligne_bl,
       zca_heimburger.cle                                     AS refart,
       zca_heimburger.quantite,
       zca_heimburger.volume                                  AS vol,
       0                                                      AS pu_brut,
       zca_heimburger.px_vte                                  AS pu_net,
       zca_heimburger.famart1                                 AS fam1,
       zca_heimburger.famart2                                 AS fam2,
       zca_heimburger.famart3                                 AS fam3,
       articles.artfam                                        AS famart,
       zca_heimburger.prix_net_st                             AS ca,
       articles.artgen,
       articles.artlib,
       zfamcli.famille3_0,
       zfamcli.famille4_0,
       zfamcli.famille5_0
FROM ( ( zca_heimburger left
    JOIN articles ON zca_heimburger.cle = articles.artnum ) left
    JOIN bpcustomer ON zca_heimburger.codecli = bpcustomer.bpcnum_0 )
         left JOIN zfamcli ON bpcustomer.bpcnum_0 = zfamcli.code_0
WHERE zca_heimburger.datefac BETWEEN TO_DATE('01/01/2019', 'DD/MM/YYYY') AND TO_DATE('31/08/2019', 'DD/MM/YYYY')
  AND zca_heimburger.typedoc <> 'FP'
  AND bpcustomer.tsccod_1 = '243'
order by 2