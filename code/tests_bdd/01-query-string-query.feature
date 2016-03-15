Feature: Full text queries

   # Use https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-query-string-query.html

  Scenario: Find pizzas that contains the word "Bacon"
    Given all pizzas is indexed
    When i make a dsl query
    """
    {
        "query": {
          "query_string": {
              "query": "Bacon"
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
                    "topping": [
                      "Bacon"
                   ],
                   "name":"American Bacon"
                }
             },
             {
                "_source": {
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