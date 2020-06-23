# bitnami-cassandra-lucene-index

Base: https://github.com/nhahv/bitnami-cassandra-lucene-index

Vietnamese Analyzer: https://github.com/nhahv/solr-vn-tokenizer 
 - [Dependence] VnCoreNLP (https://github.com/nhahv/VnCoreNLP) (Change log4j to slf4j (pom) for java.lang.IllegalStateException: Detected both log4j-over-slf4j.jar AND bound slf4j-log4j12.jar on the class path)
 - Add `org.apache.lucene.analysis.core.WhitespaceASCIIAnalyzer` for ASCIIFolding
 - Add `org.apache.lucene.analysis.vi.VietnameseAnalyzer` for Vietnamese Analyzer
 - Add `org.apache.lucene.analysis.vi.VietnameseASCIIAnalyzer` Combine 2 above

