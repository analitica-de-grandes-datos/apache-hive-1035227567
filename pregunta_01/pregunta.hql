/* 
Pregunta
===========================================================================

Para resolver esta pregunta use el archivo `data.tsv`.

Compute la cantidad de registros por cada letra de la columna 1.
Escriba el resultado ordenado por letra. 

Apache Hive se ejecutará en modo local (sin HDFS).

Escriba el resultado a la carpeta `output` de directorio de trabajo.

        >>> Escriba su respuesta a partir de este punto <<<
*/

DROP TABLE IF EXISTS datos;

DROP TABLE IF EXISTS word_counts;
CREATE TABLE datos ( c1 STRING, c2 DATE, c3 INT )
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
TBLPROPERTIES ("skip.header.line.count"="0");

LOAD DATA LOCAL INPATH "data.tsv" OVERWRITE INTO TABLE datos;

CREATE TABLE word_counts AS SELECT c1, COUNT(1)
    AS cantidad FROM datos GROUP BY c1 ORDER BY c1;

INSERT OVERWRITE LOCAL DIRECTORY './output'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
SELECT * FROM word_counts;