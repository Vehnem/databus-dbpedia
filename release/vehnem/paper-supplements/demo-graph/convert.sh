

version=20210301
rm -rf $version
mkdir -p $version

cp graph.ttl $version/demo-graph.ttl
rapper -g graph.ttl -o ntriples 2>/dev/null | tee $version/demo-graph.nt
rapper -g graph.ttl -o rdfxml 2>/dev/null | tee $version/demo-graph.rdf

curl -s 'https://www.easyrdf.org/converter' --data-urlencode "data@graph.ttl" \
	--data-urlencode "in=turtle" \
	--data-urlencode "out=jsonld" \
	--data-urlencode "raw=1" \
	--data-urlencode "uri=http://example.org/" \
	| json_pp | tee $version/demo-graph.jsonld


curl -s 'https://www.ldf.fi/service/rdf-grapher' --data-urlencode "rdf@graph.ttl" --output $version/demo-graph.png
feh $version/demo-graph.png
