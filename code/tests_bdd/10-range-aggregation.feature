Feature: Aggregations

  # Use https://www.elastic.co/guide/en/elasticsearch/reference/current/search-aggregations-bucket-range-aggregation.html

  Scenario: Find out how many pizza's weight between 0-500, 500-1000, and 1000-1500?
    Given all pizzas is indexed
    When i make a dsl query
    """
    {
        "aggs" : {
            "weight_ranges" : {
                "range" : {
                    "field" : "weight",
                    "ranges" : [
                        { "to" : 500 },
                        { "from" : 500, "to" : 1000 },
                        { "from" : 1000, "to" : 1500 }
                    ]
                }
            }
        }
    }
    """
    Then the response should contain
    """
    {
      "aggregations": {
        "weight_ranges": {
           "buckets": [
              {
                 "to": 500,
                 "doc_count": 0
              },
              {
                 "from": 500,
                 "to": 1000,
                 "doc_count": 9
              },
              {
                 "from": 1000,
                 "doc_count": 1
              }
           ]
        }
      }
    }
    """