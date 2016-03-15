Feature: Term level queries

  # For range search (>, >=, <, <=),
  # use https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-range-query.html#query-dsl-range-query

  Scenario: Find pizzas with weight greater-than or equal to 1000
    Given all pizzas is indexed
    When i make a dsl query
    """
    {
       "query":{
          "filtered":{
             "filter":{
                "range":{
                   "weight":{
                      "gte":1000
                   }
                }
             }
          }
       }
    }
    """
    Then the response should contain
    """
    {
       "hits":
       {
          "total":1,
          "hits":
          [
             {
                "_source":{
                   "weight":1015,
                   "name":"Take Away Meat Lover"
                }
             }
          ]
       }
    }
    """