SELECT histo_factures.numfac,
       histo_factures.datefac,
       TO_CHAR(datefac, 'MONTH', 'nls_date_language= FRENCH')  as mois,
       TO_CHAR(datefac, 'RRRR')                                as annee,
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
       DECODE(typedoc, 'FC', qte, - qte)                       as quantite,
       DECODE(typedoc, 'FC', volume, - volume)                 as vol,
       histo_factures.pu_brut,
       histo_factures.pu_net,
       histo_factures.fam1,
       histo_factures.fam2,
       histo_factures.fam3,
       histo_factures.famart,
       DECODE(typedoc, 'FC', total_ht_ligne, - total_ht_ligne) as ca,
       articles.artgen,
       bpcustomer.bpcpyr_0,
       articles.artlib
FROM histo_factures histo_factures,
     articles articles,
     bpcustomer bpcustomer
WHERE (HISTO_FACTURES.DATEFAC BETWEEN to_date(?1, 'DD/MM/YYYY') AND to_date(?2, 'DD/MM/YYYY')
    OR HISTO_FACTURES.DATEFAC BETWEEN to_date(?3, 'DD/MM/YYYY') AND to_date(?4, 'DD/MM/YYYY'))
  AND histo_factures.refart = articles.artnum (+)
  AND histo_factures.codecli = bpcustomer.bpcnum_0 (+)
  AND histo_factures.typedoc <> 'FP'
  AND bpcustomer.bpcnum_0 = '000522'
UNION ALL
SELECT zca_heimburger.numfac,
       zca_heimburger.datefac,
       TO_CHAR(datefac, 'MONTH', 'nls_date_language= FRENCH') as mois,
       TO_CHAR(datefac, 'RRRR')                               as annee,
       zca_heimburger.numligne,
       zca_heimburger.typedoc,
       zca_heimburger.codecli,
       zca_heimburger.rep,
       zca_heimburger.totalht,
       zca_heimburger.totaltva,
       zca_heimburger.totalttc,
       zca_heimburger.numbl,
       zca_heimburger.numligne_bl,
       zca_heimburger.cle,
       zca_heimburger.quantite,
       zca_heimburger.volume                                  as vol,
       0,
       zca_heimburger.px_vte,
       zca_heimburger.famart1,
       zca_heimburger.famart2,
       zca_heimburger.famart3,
       articles.artfam,
       zca_heimburger.prix_net_st                             as ca,
       articles.artgen,
       bpcustomer.bpcpyr_0,
       articles.artlib
FROM zca_heimburger zca_heimburger,
     articles articles,
     bpcustomer bpcustomer
WHERE (ZCA_HEIMBURGER.DATEFAC BETWEEN to_date(?1, 'DD/MM/YYYY') AND to_date(?2, 'DD/MM/YYYY')
    OR ZCA_HEIMBURGER.DATEFAC BETWEEN to_date(?3, 'DD/MM/YYYY') AND to_date(?4, 'DD/MM/YYYY'))
  AND zca_heimburger.cle = articles.artnum
  AND zca_heimburger.codecli = bpcustomer.bpcnum_0
  AND bpcustomer.bpcnum_0 = '000522'
order by 2