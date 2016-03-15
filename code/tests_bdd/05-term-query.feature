Feature: Term level queries

  # Use https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-term-query.html
  # Need custom mapping also.

  Scenario: Find pizzas that has "Marinated Beef" topping
    Given all pizzas is indexed
    When i make a dsl query
    """
    {
      "query":{
        "term":{
          "topping":"Marinated Beef"
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
                   "name":"Take Away Meat Lover"
                }
             }
          ]
       }
    }
    """