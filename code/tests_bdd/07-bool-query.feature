Feature: Full text and term level queries combined

  # Use https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-bool-query.html

  Scenario: Find pizzas with a name that contains the word "California" and that has "Meatballs" topping
    Given all pizzas is indexed
    When i make a dsl query
    """
    {
       "query":{
          "filtered":{
             "filter":{
                "bool":{
                   "must":[
                      {
                         "query":{
                            "match":{
                               "name":"California"
                            }
                         }
                      },
                      {
                         "query":{
                            "term":{
                               "topping":"Meatballs"
                            }
                         }
                      }
                   ]
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
                   "name":"California Meatballs"
                }
             }
          ]
       }
    }
    """