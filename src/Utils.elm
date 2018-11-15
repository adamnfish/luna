module Utils exposing (arrMapWithOthers, flattenList, repeatFn)

import Array exposing (Array)


arrMapWithOthers : ( a -> Array a -> b ) -> Array a -> Array b
arrMapWithOthers f aa =
  let
    els = Array.toIndexedList aa
    elsWithoutI : Int -> Array a
    elsWithoutI excludeIndex =
      let
        otherEls =
          List.foldr
            ( \(i, a) acc ->
              if i == excludeIndex then
                acc
              else
                a :: acc
            )
            []
            els
      in
        Array.fromList otherEls
  in
    Array.indexedMap
      ( \i a ->
        f a ( elsWithoutI i )
      )
      aa

flattenList : List ( List a ) -> List a
flattenList list =
  List.foldr (++) [] list

-- apply the given function repeatedly,
-- using output of preious invocation as argument
repeatFn : ( a -> a ) -> Int -> a -> a
repeatFn f n a =
  let
    fns = List.repeat n f
  in
    List.foldl ( \fni ai -> fni ai ) a fns
