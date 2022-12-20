--SELECT x.a > (SELECT SUM(y.a) AS b FROM y) FROM x;
--------------------------------------
-- Unnest Subqueries
--------------------------------------
SELECT *
FROM x AS x
WHERE
  x.a = (SELECT SUM(y.a) AS a FROM y)
  AND x.a IN (SELECT y.a AS a FROM y)
  AND x.a IN (SELECT y.b AS b FROM y)
  AND x.a = ANY (SELECT y.a AS a FROM y)
  AND x.a = (SELECT SUM(y.b) AS b FROM y WHERE x.a = y.a)
  AND x.a > (SELECT SUM(y.b) AS b FROM y WHERE x.a = y.a)
  AND x.a <> ANY (SELECT y.a AS a FROM y WHERE y.a = x.a)
  AND x.a NOT IN (SELECT y.a AS a FROM y WHERE y.a = x.a)
  AND x.a IN (SELECT y.a AS a FROM y WHERE y.b = x.a)
  AND x.a < (SELECT SUM(y.a) AS a FROM y WHERE y.a = x.a and y.a = x.b and y.b <> x.d)
  AND EXISTS (SELECT y.a AS a, y.b AS b FROM y WHERE x.a = y.a)
  AND x.a IN (SELECT y.a AS a FROM y LIMIT 10)
  AND x.a IN (SELECT y.a AS a FROM y OFFSET 10)
  AND x.a IN (SELECT y.a AS a, y.b AS b FROM y)
  AND x.a > ANY (SELECT y.a FROM y)
  AND x.a = (SELECT SUM(y.c) AS c FROM y WHERE y.a = x.a LIMIT 10)
  AND x.a = (SELECT SUM(y.c) AS c FROM y WHERE y.a = x.a OFFSET 10)
;
SELECT
  *
FROM x AS x
CROSS JOIN (
  SELECT
    SUM(y.a) AS a
  FROM y
) AS "_u_0"
LEFT JOIN (
  SELECT
    y.a AS a
  FROM y
  GROUP BY
    y.a
) AS "_u_1"
  ON x.a = "_u_1"."a"
LEFT JOIN (
  SELECT
    y.b AS b
  FROM y
  GROUP BY
    y.b
) AS "_u_2"
  ON x.a = "_u_2"."b"
LEFT JOIN (
  SELECT
    y.a AS a
  FROM y
  GROUP BY
    y.a
) AS "_u_3"
  ON x.a = "_u_3"."a"
LEFT JOIN (
  SELECT
    SUM(y.b) AS b,
    y.a AS _u_5
  FROM y
  WHERE
    TRUE
  GROUP BY
    y.a
) AS "_u_4"
  ON x.a = "_u_4"."_u_5"
LEFT JOIN (
  SELECT
    SUM(y.b) AS b,
    y.a AS _u_7
  FROM y
  WHERE
    TRUE
  GROUP BY
    y.a
) AS "_u_6"
  ON x.a = "_u_6"."_u_7"
LEFT JOIN (
  SELECT
    y.a AS a
  FROM y
  WHERE
    TRUE
  GROUP BY
    y.a
) AS "_u_8"
  ON "_u_8".a = x.a
LEFT JOIN (
  SELECT
    y.a AS a
  FROM y
  WHERE
    TRUE
  GROUP BY
    y.a
) AS "_u_9"
  ON "_u_9".a = x.a
LEFT JOIN (
  SELECT
    ARRAY_AGG(y.a) AS a,
    y.b AS _u_11
  FROM y
  WHERE
    TRUE
  GROUP BY
    y.b
) AS "_u_10"
  ON "_u_10"."_u_11" = x.a
LEFT JOIN (
  SELECT
    SUM(y.a) AS a,
    y.a AS _u_13,
    ARRAY_AGG(y.b) AS _u_14
  FROM y
  WHERE
    TRUE AND TRUE AND TRUE
  GROUP BY
    y.a
) AS "_u_12"
  ON "_u_12"."_u_13" = x.a AND "_u_12"."_u_13" = x.b
LEFT JOIN (
  SELECT
    y.a AS a
  FROM y
  WHERE
    TRUE
  GROUP BY
    y.a
) AS "_u_15"
  ON x.a = "_u_15".a
WHERE
  x.a = "_u_0".a
  AND NOT "_u_1"."a" IS NULL
  AND NOT "_u_2"."b" IS NULL
  AND NOT "_u_3"."a" IS NULL
  AND (
    x.a = "_u_4".b AND NOT "_u_4"."_u_5" IS NULL
  )
  AND (
    x.a > "_u_6".b AND NOT "_u_6"."_u_7" IS NULL
  )
  AND (
    None = "_u_8".a AND NOT "_u_8".a IS NULL
  )
  AND NOT (
    x.a = "_u_9".a AND NOT "_u_9".a IS NULL
  )
  AND (
    ARRAY_ANY("_u_10".a, _x -> _x = x.a) AND NOT "_u_10"."_u_11" IS NULL
  )
  AND (
    (
      (
        x.a < "_u_12".a AND NOT "_u_12"."_u_13" IS NULL
      ) AND NOT "_u_12"."_u_13" IS NULL
    )
    AND ARRAY_ANY("_u_12"."_u_14", "_x" -> "_x" <> x.d)
  )
  AND (
    NOT "_u_15".a IS NULL AND NOT "_u_15".a IS NULL
  )
  AND x.a IN (
    SELECT
      y.a AS a
    FROM y
    LIMIT 10
  )
  AND x.a IN (
    SELECT
      y.a AS a
    FROM y
    OFFSET 10
  )
  AND x.a IN (
    SELECT
      y.a AS a,
      y.b AS b
    FROM y
  )
  AND x.a > ANY (
    SELECT
      y.a
    FROM y
  )
  AND x.a = (
    SELECT
      SUM(y.c) AS c
    FROM y
    WHERE
      y.a = x.a
    LIMIT 10
  )
  AND x.a = (
    SELECT
      SUM(y.c) AS c
    FROM y
    WHERE
      y.a = x.a
    OFFSET 10
  );

SELECT
  (
    SELECT
      s.name AS name
    FROM student AS s
    WHERE
      s.sid = e.sid
  ) AS sname
FROM enrolled AS e
WHERE
  e.cid = '15-445';
SELECT
  "_u_0".name AS sname
FROM enrolled AS e
LEFT JOIN (
  SELECT
    MAX(s.name) AS name,
    s.sid AS _u_1
  FROM student AS s
  WHERE
    TRUE
  GROUP BY
    s.sid
) AS "_u_0"
  ON "_u_0"."_u_1" = e.sid
WHERE
  e.cid = '15-445';
