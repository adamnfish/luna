module UtilsTests exposing (..)

import Array exposing (Array)
import Expect
import Test exposing (..)

import Utils exposing (arrMapWithOthers)


all : Test
all =
  describe "arrMapWithOthers"
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
