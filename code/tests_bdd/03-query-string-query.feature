Feature: Full text queries

   # Use https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-query-string-query.html

  Scenario: Find pizzas that contains both the words "Bacon" and "Lover"
    Given all pizzas is indexed
    When i make a dsl query
    """
    {
        "query": {
          "query_string": {
              "query": "Bacon Lover",
              "default_operator": "and"
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
                    "topping": [
                      "Meatballs",
                      "Marinated Beef",
                      "Bacon"
                    ],
                    "name": "Take Away Meat Lover"
                }
             }
          ]
       }
    }
    """