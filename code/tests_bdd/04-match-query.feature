Feature: Full text queries

   # Use https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-match-query.html

  Scenario: Find pizzas with a name that contains the word "American"
    Given all pizzas is indexed
    When i make a dsl query
    """
    {
       "query": {
          "match": {
             "name" : "American"
          }
       }
    }
    """
    Then the response should contain
    """
    {
       "hits":
       {
          "total":2,
          "hits":
          [
             {
                "_source":{
                   "name":"Classic American"
                }
             },
             {
                "_source": {
                   "name": "American Bacon"
                }
             }
          ]
       }
    }
    """