# Logscope
Logscope is an implementation of an open assignment [ASSIGNMENT.md](./ASSIGNMENT.md).

## Introduction
Logscope system consists of the following process:

#### Collector
Collector service exposes a POST API where applications can send logs.

#### Ingestor
Ingestor ingests the collected logs into a database.

#### Query
Query service expose two GET API endpoints:
- **Filtered Search**: Filtered Search endpoint enables the consumer to specify columns and values to search in them. Every column has regex (lucene) support.
- **Ranked Search**: Ranked Search endpoint enables the consumer to perform a ranked search across all columns. This endpoint is suitable when the searched value need not be associated with a column (filter).

Filtered and Ranked searches are paginated. Date ranges can optionally be specified in both the endpoints.

#### Generator
Generator is a log generator script to generate upload a specified number of diverse type of logs for application demo.

## Results
Logscope can efficiently collect and ingest application logs. It can also query and produce the search results with sub-millisecond latency.
