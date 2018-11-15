module UtilsTests exposing (..)

import Array exposing (Array)
import Expect
import Test exposing (..)
import Fuzz

import Utils exposing (arrMapWithOthers, flattenList, repeatFn)


all : Test
all =
  describe "utils"
    [ describe "arrMapWithOthers"
      [ test "works with one item" <|
        \_ ->
          Expect.equal
            ( Array.fromList
              [ (1, Array.empty ) ]
            )
            ( arrMapWithOthers (\a b -> (a, b)) ( Array.fromList [ 1 ] ) )
      , test "works with two items" <|
        \_ ->
          Expect.equal
            ( Array.fromList
              [ (1, Array.fromList [2] )
              , (2, Array.fromList [1] )
              ]
            )
            ( arrMapWithOthers (\a b -> (a, b)) ( Array.fromList [ 1, 2 ] ) )
      , test "works with three items" <|
              \_ ->
                Expect.equal
                  ( Array.fromList
                    [ (1, Array.fromList [2, 3] )
                    , (2, Array.fromList [1, 3] )
                    , (3, Array.fromList [1, 2] )
                    ]
                  )
                  ( arrMapWithOthers (\a b -> (a, b)) ( Array.fromList [ 1, 2, 3 ] ) )
  --    , test "String.left" <|
  --      \_ ->
  --        Expect.equal "a" (String.left 1 "abcdefg")
  --    , test "This test should fail" <|
  --      \_ ->
  --        Expect.fail "failed as expected!"
      ]
    , describe "repeatFn"
        [ fuzz ( Fuzz.intRange 0 100 ) "applies given function correct number of times" <|
          \n ->
            Expect.equal n ( repeatFn ( (+) 1 ) n 0 )
        ]
    , describe "flattenList"
        [ test "flattens empty list" <|
          \_ ->
            Expect.equal [] ( flattenList [] )
        , test "flattens nested list" <|
          \_ ->
            Expect.equal [ 1, 2, 3, 4 ] ( flattenList [ [ 1, 2 ], [ 3, 4 ] ] )
        ]
    ]
