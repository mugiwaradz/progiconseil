SELECT HISTO_FACTURES.NUMFAC,
       HISTO_FACTURES.DATEFAC,
       TO_CHAR(datefac, 'MONTH', 'nls_date_language= FRENCH')  as mois,
       TO_CHAR(datefac, 'RRRR')                                as annee,
       HISTO_FACTURES.NUMLIGNE,
       HISTO_FACTURES.TYPEDOC,
       HISTO_FACTURES.CODECLI,
       HISTO_FACTURES.REP,
       HISTO_FACTURES.TOTALHT,
       HISTO_FACTURES.TOTALTVA,
       HISTO_FACTURES.TOTALTTC,
       HISTO_FACTURES.NUMBL,
       HISTO_FACTURES.NUMLIGNE_BL,
       HISTO_FACTURES.REFART,
       DECODE(typedoc, 'FC', qte, - qte)                       AS QUANTITE,
       DECODE(typedoc, 'FC', volume, - volume)                 AS VOL,
       HISTO_FACTURES.PU_BRUT,
       HISTO_FACTURES.PU_NET,
       HISTO_FACTURES.FAM1,
       HISTO_FACTURES.FAM2,
       HISTO_FACTURES.FAM3,
       HISTO_FACTURES.FAMART,
       DECODE(typedoc, 'FC', total_ht_ligne, - total_ht_ligne) AS CA,
       ARTICLES.artgen,
       BPCUSTOMER.BPCPYR_0,
       ARTICLES.artlib
FROM (HISTO_FACTURES LEFT JOIN ARTICLES ON HISTO_FACTURES.REFART = ARTICLES.ARTNUM)
         LEFT JOIN BPCUSTOMER ON HISTO_FACTURES.CODECLI = BPCUSTOMER.BPCNUM_0
WHERE (HISTO_FACTURES.DATEFAC BETWEEN to_date(?1, 'DD/MM/YYYY') AND to_date(?2, 'DD/MM/YYYY')
    OR HISTO_FACTURES.DATEFAC BETWEEN to_date(?3, 'DD/MM/YYYY') AND to_date(?4, 'DD/MM/YYYY'))
  AND HISTO_FACTURES.TYPEDOC <> 'FP'
  AND BPCUSTOMER.BPCPYR_0 In ('003378', '001338', '001328')
UNION ALL
SELECT ZCA_HEIMBURGER.NUMFAC,
       ZCA_HEIMBURGER.DATEFAC,
       TO_CHAR(datefac, 'MONTH', 'nls_date_language= FRENCH') as mois,
       TO_CHAR(datefac, 'RRRR')                               as annee,
       ZCA_HEIMBURGER.NUMLIGNE,
       ZCA_HEIMBURGER.TYPEDOC,
       ZCA_HEIMBURGER.CODECLI,
       ZCA_HEIMBURGER.REP,
       ZCA_HEIMBURGER.TOTALHT,
       ZCA_HEIMBURGER.TOTALTVA,
       ZCA_HEIMBURGER.TOTALTTC,
       ZCA_HEIMBURGER.NUMBL,
       ZCA_HEIMBURGER.NUMLIGNE_BL,
       ZCA_HEIMBURGER.CLE                                     AS REFART,
       ZCA_HEIMBURGER.QUANTITE,
       ZCA_HEIMBURGER.VOLUME                                  AS VOL,
       0                                                      AS PU_BRUT,
       ZCA_HEIMBURGER.PX_VTE                                  AS PU_NET,
       ZCA_HEIMBURGER.FAMART1                                 AS FAM1,
       ZCA_HEIMBURGER.FAMART2                                 AS FAM2,
       ZCA_HEIMBURGER.FAMART3                                 AS FAM3,
       ARTICLES.ARTFAM                                        AS FAMART,
       ZCA_HEIMBURGER.PRIX_NET_ST                             AS CA,
       ARTICLES.artgen,
       BPCUSTOMER.BPCPYR_0,
       ARTICLES.artlib
FROM (ZCA_HEIMBURGER LEFT JOIN ARTICLES ON ZCA_HEIMBURGER.CLE = ARTICLES.ARTNUM)
         LEFT JOIN BPCUSTOMER ON ZCA_HEIMBURGER.CODECLI = BPCUSTOMER.BPCNUM_0
WHERE (ZCA_HEIMBURGER.DATEFAC BETWEEN to_date(?1, 'DD/MM/YYYY') AND to_date(?2, 'DD/MM/YYYY')
    OR ZCA_HEIMBURGER.DATEFAC BETWEEN to_date(?3, 'DD/MM/YYYY') AND to_date(?4, 'DD/MM/YYYY'))
  AND ZCA_HEIMBURGER.TYPEDOC <> 'FP'
  AND BPCUSTOMER.BPCPYR_0 In ('003378', '001338', '001328')
order by 2