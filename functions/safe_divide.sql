CASE 
    WHEN denominator = 0
    THEN null
    ELSE numerator/denominator
END