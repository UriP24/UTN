-----------------------------------------------------------------------------
-- |
-- Module      :  Data.Traversable
-- Copyright   :  Conor McBride and Ross Paterson 2005
-- License     :  BSD-style (see the LICENSE file in the distribution)
--
-- Maintainer  :  ross@soi.city.ac.uk
-- Stability   :  experimental
-- Portability :  portable
--
-- Class of data structures that can be traversed from left to right.
--
-- See also /Applicative Programming with Effects/,
-- by Conor McBride and Ross Paterson, online at
-- <http://www.soi.city.ac.uk/~ross/papers/Applicative.html>.

module Data.Traversable (
	Traversable(..),
	fmapDefault,
	foldMapDefault,
	) where

import Prelude hiding (mapM, sequence)
import qualified Prelude (mapM)
import Control.Applicative
import Data.Foldable (Foldable)
import Data.Monoid (Monoid)
import Data.Array

-- | Functors representing data structures that can be traversed from
-- left to right.
--
-- Minimal complete definition: 'traverse' or 'sequenceA'.
--
-- Instances are similar to 'Functor', e.g. given a data type
--
-- > data Tree a = Empty | Leaf a | Node (Tree a) a (Tree a)
--
-- a suitable instance would be
--
-- > instance Traversable Tree
-- >	traverse f Empty = pure Empty
-- >	traverse f (Leaf x) = Leaf <$> f x
-- >	traverse f (Node l k r) = Node <$> traverse f l <*> f k <*> traverse f r
--
-- This is suitable even for abstract types, as the laws for '<*>'
-- imply a form of associativity.
--
class (Functor t, Foldable t) => Traversable t where
	-- | Map each element of a structure to an action, evaluate
	-- these actions from left to right, and collect the results.
	traverse :: Applicative f => (a -> f b) -> t a -> f (t b)
	traverse f = sequenceA . fmap f

	-- | Evaluate each action in the structure from left to right,
	-- and collect the results.
	sequenceA :: Applicative f => t (f a) -> f (t a)
	sequenceA = traverse id

	-- | Map each element of a structure to an monadic action, evaluate
	-- these actions from left to right, and collect the results.
	mapM :: Monad m => (a -> m b) -> t a -> m (t b)
	mapM f = unwrapMonad . traverse (WrapMonad . f)

	-- | Evaluate each monadic action in the structure from left to right,
	-- and collect the results.
	sequence :: Monad m => t (m a) -> m (t a)
	sequence = mapM id

-- instances for Prelude types

instance Traversable Maybe where
	traverse f Nothing = pure Nothing
	traverse f (Just x) = Just <$> f x

instance Traversable [] where
	traverse f = foldr cons_f (pure [])
	  where cons_f x ys = (:) <$> f x <*> ys

	mapM = Prelude.mapM

instance Ix i => Traversable (Array i) where
	traverse f arr = listArray (bounds arr) <$> traverse f (elems arr)

-- general functions

-- | This function may be used as a value for `fmap` in a `Functor` instance.
fmapDefault :: Traversable t => (a -> b) -> t a -> t b
fmapDefault f = getId . traverse (Id . f)

-- | This function may be used as a value for `Data.Foldable.foldMap`
-- in a `Foldable` instance.
foldMapDefault :: (Traversable t, Monoid m) => (a -> m) -> t a -> m
foldMapDefault f = getConst . traverse (Const . f)

-- local instances

newtype Id a = Id { getId :: a }

instance Functor Id where
	fmap f (Id x) = Id (f x)

instance Applicative Id where
	pure = Id
	Id f <*> Id x = Id (f x)
