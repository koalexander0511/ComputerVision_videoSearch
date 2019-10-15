function sim = getSimilarity(bow1, bow2)
dotProd = dot(bow1,bow2);
bow1mag = norm(bow1);
bow2mag = norm(bow2);

sim = dotProd / (bow1mag * bow2mag);
end