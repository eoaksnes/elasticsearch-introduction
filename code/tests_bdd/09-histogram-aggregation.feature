Feature: Aggregations

  # Use https://www.elastic.co/guide/en/elasticsearch/reference/current/search-aggregations-bucket-histogram-aggregation.html

  Scenario: Histogram of pizza's weight with interval 1000
    Given all pizzas is indexed
    When i make a dsl query
    """
    {
       "aggs": {
           "by_weight": {
              "histogram": {
                 "field": "weight",
                 "interval": 100
              }
           }
       }
    }
    """
    Then the response should contain
    """
    {
      "aggregations": {
        "by_weight": {
           "buckets": [
            {
               "key": 500,
               "doc_count": 3
            },
            {
               "key": 600,
               "doc_count": 6
            },
            {
               "key": 1000,
               "doc_count": 1
            }
         ]
        }
      }
    }
    """