{-# OPTIONS_GHC -fno-implicit-prelude #-}
-----------------------------------------------------------------------------
-- |
-- Module      :  Foreign.Ptr
-- Copyright   :  (c) The FFI task force 2001
-- License     :  BSD-style (see the file libraries/base/LICENSE)
-- 
-- Maintainer  :  ffi@haskell.org
-- Stability   :  provisional
-- Portability :  portable
--
-- This module provides typed pointers to foreign data.  It is part
-- of the Foreign Function Interface (FFI) and will normally be
-- imported via the "Foreign" module.
--
-----------------------------------------------------------------------------

module Foreign.Ptr (

    -- * Data pointers
    
    Ptr,      -- data Ptr a
    nullPtr,      -- :: Ptr a
    castPtr,      -- :: Ptr a -> Ptr b
    plusPtr,      -- :: Ptr a -> Int -> Ptr b
    alignPtr,     -- :: Ptr a -> Int -> Ptr a
    minusPtr,     -- :: Ptr a -> Ptr b -> Int
    
    -- * Function pointers
    
    FunPtr,      -- data FunPtr a
    nullFunPtr,      -- :: FunPtr a
    castFunPtr,      -- :: FunPtr a -> FunPtr b
    castFunPtrToPtr, -- :: FunPtr a -> Ptr b
    castPtrToFunPtr, -- :: Ptr a -> FunPtr b
    
    freeHaskellFunPtr, -- :: FunPtr a -> IO ()
    -- Free the function pointer created by foreign export dynamic.


    -- * Integral types with lossless conversion to/from pointers
    IntPtr,
    ptrToIntPtr,
    intPtrToPtr,
    WordPtr,
    ptrToWordPtr,
    wordPtrToPtr

 ) where















import Foreign.C.Types


import Control.Monad	( liftM )
import Data.Bits
import Data.Typeable 	( Typeable(..), mkTyCon, mkTyConApp )
import Foreign.Storable ( Storable(..) )



















import Hugs.Ptr












                                                       
                                                                             

                         


                          


                              


                                 


                        


                                


                          


                            


                         


                           


                           


                         


                          


                         


                                


                                


                              


                           


                                


                          


                        


                          


                          


                          


                         


                          


                             


                                


                         


                          


                               


                         


                          


                       


                           


                          


                         


                          


                          


                            


                             


                                


                            


                             


                               


                          


                           


                            


                           


                          


                          


                           


                          


                           


                          


                          


                          


                               


                          


                         


                          


                          


                           


                            


                           


                             


                            


                          


                         


                              


                         


                                


                         


                            


                                


                                 


                                


                          


                                   


                              


                          


                           


                           


                         


                                


                            


                             


                                   


                          


                         


                          


                          


                         


                             


                                


                           


                          


                               


                         


                            


                           


                           


                          


                           


                           


                          


                          


                          


                          


                           


                           


                           


                           


                           


                           


                           


                          


                           


                           


                           


                           


                           


                          


                           


                           


                             


                           


                           


                             


                           


                           


                           


                               


                               


                                                        


                                                        


                                                   


                                                       


                                                      
                          

                                                           


                                                      


                                                         
                             

                                                         


                                                   
                       

                                                         


                                                       
                           

                                                     
                         

                                                        
                         

                                                         


                                                         


                                                         


                                                          


                                                         


                                                               
                                

                                                           


                                                            


                                                          
                           

                                                       


                                                         


                                                         


                                                     


                                     
                       

                                     


                                        


                                      


                                       


                                      


                                      
                        

                                      


                                    


                                         


                                         


                                     


                                          


                                       


                                        
                          

                                      


                                      


                                          


                                       
                         

                                      


                                            


                                             


                                       


                                        
                          

                                        


                                         
                           

                                       


                                      
                        

                                          


                                          


                                              


                                             


                                              


                                                   


                                               


                                        


                                       


                                                                              


                                              


                                                          


                                                          


                                            


                                           


                                                      


                                                                       
                              

                                                 
                         


                                                                                                                                                                                                                                              




                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
























































                                                                                                                                                                                                                                        

                                                                


































































































































































































































newtype WordPtr = WordPtr CUIntPtr deriving (Eq, Ord) ; instance Num WordPtr where {    (WordPtr i) + (WordPtr j) = WordPtr (i + j) ;    (WordPtr i) - (WordPtr j) = WordPtr (i - j) ;    (WordPtr i) * (WordPtr j) = WordPtr (i * j) ;    negate  (WordPtr i) = WordPtr (negate i) ;    abs     (WordPtr i) = WordPtr (abs    i) ;    signum  (WordPtr i) = WordPtr (signum i) ;    fromInteger x = WordPtr (fromInteger x) } ; instance Real WordPtr where {    toRational (WordPtr i) = toRational i } ; instance Read WordPtr where {    readsPrec p s = map (\(x, t) -> (WordPtr x, t)) (readsPrec p s) } ; instance Show WordPtr where {    showsPrec p (WordPtr x) = showsPrec p x } ; instance Enum WordPtr where {    succ           (WordPtr i)             = WordPtr (succ i) ;    pred           (WordPtr i)             = WordPtr (pred i) ;    toEnum               x           = WordPtr (toEnum x) ;    fromEnum       (WordPtr i)             = fromEnum i ;    enumFrom       (WordPtr i)             = map WordPtr (enumFrom i) ;    enumFromThen   (WordPtr i) (WordPtr j)       = map WordPtr (enumFromThen i j) ;    enumFromTo     (WordPtr i) (WordPtr j)       = map WordPtr (enumFromTo i j) ;    enumFromThenTo (WordPtr i) (WordPtr j) (WordPtr k) = map WordPtr (enumFromThenTo i j k) } ; instance Storable WordPtr where {    sizeOf    (WordPtr x)       = sizeOf x ;    alignment (WordPtr x)       = alignment x ;    peekElemOff a i       = liftM WordPtr (peekElemOff (castPtr a) i) ;    pokeElemOff a i (WordPtr x) = pokeElemOff (castPtr a) i x } ; tyConWordPtr = mkTyCon "WordPtr"; instance Typeable WordPtr where { typeOf _ = mkTyConApp tyConWordPtr [] } ; ; instance Bounded WordPtr where {    minBound = WordPtr minBound ;    maxBound = WordPtr maxBound } ; instance Integral WordPtr where {    (WordPtr i) `quot`    (WordPtr j) = WordPtr (i `quot` j) ;    (WordPtr i) `rem`     (WordPtr j) = WordPtr (i `rem`  j) ;    (WordPtr i) `div`     (WordPtr j) = WordPtr (i `div`  j) ;    (WordPtr i) `mod`     (WordPtr j) = WordPtr (i `mod`  j) ;    (WordPtr i) `quotRem` (WordPtr j) = let (q,r) = i `quotRem` j in (WordPtr q, WordPtr r) ;    (WordPtr i) `divMod`  (WordPtr j) = let (d,m) = i `divMod`  j in (WordPtr d, WordPtr m) ;    toInteger (WordPtr i)       = toInteger i } ; instance Bits WordPtr where {   (WordPtr x) .&.     (WordPtr y)   = WordPtr (x .&.   y) ;   (WordPtr x) .|.     (WordPtr y)   = WordPtr (x .|.   y) ;   (WordPtr x) `xor`   (WordPtr y)   = WordPtr (x `xor` y) ;   complement    (WordPtr x)   = WordPtr (complement x) ;   shift         (WordPtr x) n = WordPtr (shift x n) ;   rotate        (WordPtr x) n = WordPtr (rotate x n) ;   bit                 n = WordPtr (bit n) ;   setBit        (WordPtr x) n = WordPtr (setBit x n) ;   clearBit      (WordPtr x) n = WordPtr (clearBit x n) ;   complementBit (WordPtr x) n = WordPtr (complementBit x n) ;   testBit       (WordPtr x) n = testBit x n ;   bitSize       (WordPtr x)   = bitSize x ;   isSigned      (WordPtr x)   = isSigned x }
newtype IntPtr = IntPtr CIntPtr deriving (Eq, Ord) ; instance Num IntPtr where {    (IntPtr i) + (IntPtr j) = IntPtr (i + j) ;    (IntPtr i) - (IntPtr j) = IntPtr (i - j) ;    (IntPtr i) * (IntPtr j) = IntPtr (i * j) ;    negate  (IntPtr i) = IntPtr (negate i) ;    abs     (IntPtr i) = IntPtr (abs    i) ;    signum  (IntPtr i) = IntPtr (signum i) ;    fromInteger x = IntPtr (fromInteger x) } ; instance Real IntPtr where {    toRational (IntPtr i) = toRational i } ; instance Read IntPtr where {    readsPrec p s = map (\(x, t) -> (IntPtr x, t)) (readsPrec p s) } ; instance Show IntPtr where {    showsPrec p (IntPtr x) = showsPrec p x } ; instance Enum IntPtr where {    succ           (IntPtr i)             = IntPtr (succ i) ;    pred           (IntPtr i)             = IntPtr (pred i) ;    toEnum               x           = IntPtr (toEnum x) ;    fromEnum       (IntPtr i)             = fromEnum i ;    enumFrom       (IntPtr i)             = map IntPtr (enumFrom i) ;    enumFromThen   (IntPtr i) (IntPtr j)       = map IntPtr (enumFromThen i j) ;    enumFromTo     (IntPtr i) (IntPtr j)       = map IntPtr (enumFromTo i j) ;    enumFromThenTo (IntPtr i) (IntPtr j) (IntPtr k) = map IntPtr (enumFromThenTo i j k) } ; instance Storable IntPtr where {    sizeOf    (IntPtr x)       = sizeOf x ;    alignment (IntPtr x)       = alignment x ;    peekElemOff a i       = liftM IntPtr (peekElemOff (castPtr a) i) ;    pokeElemOff a i (IntPtr x) = pokeElemOff (castPtr a) i x } ; tyConIntPtr = mkTyCon "IntPtr"; instance Typeable IntPtr where { typeOf _ = mkTyConApp tyConIntPtr [] } ; ; instance Bounded IntPtr where {    minBound = IntPtr minBound ;    maxBound = IntPtr maxBound } ; instance Integral IntPtr where {    (IntPtr i) `quot`    (IntPtr j) = IntPtr (i `quot` j) ;    (IntPtr i) `rem`     (IntPtr j) = IntPtr (i `rem`  j) ;    (IntPtr i) `div`     (IntPtr j) = IntPtr (i `div`  j) ;    (IntPtr i) `mod`     (IntPtr j) = IntPtr (i `mod`  j) ;    (IntPtr i) `quotRem` (IntPtr j) = let (q,r) = i `quotRem` j in (IntPtr q, IntPtr r) ;    (IntPtr i) `divMod`  (IntPtr j) = let (d,m) = i `divMod`  j in (IntPtr d, IntPtr m) ;    toInteger (IntPtr i)       = toInteger i } ; instance Bits IntPtr where {   (IntPtr x) .&.     (IntPtr y)   = IntPtr (x .&.   y) ;   (IntPtr x) .|.     (IntPtr y)   = IntPtr (x .|.   y) ;   (IntPtr x) `xor`   (IntPtr y)   = IntPtr (x `xor` y) ;   complement    (IntPtr x)   = IntPtr (complement x) ;   shift         (IntPtr x) n = IntPtr (shift x n) ;   rotate        (IntPtr x) n = IntPtr (rotate x n) ;   bit                 n = IntPtr (bit n) ;   setBit        (IntPtr x) n = IntPtr (setBit x n) ;   clearBit      (IntPtr x) n = IntPtr (clearBit x n) ;   complementBit (IntPtr x) n = IntPtr (complementBit x n) ;   testBit       (IntPtr x) n = testBit x n ;   bitSize       (IntPtr x)   = bitSize x ;   isSigned      (IntPtr x)   = isSigned x }

{-# CFILES cbits/PrelIOUtils.c #-}

foreign import ccall unsafe "__hscore_to_uintptr"
    ptrToWordPtr :: Ptr a -> WordPtr

foreign import ccall unsafe "__hscore_from_uintptr"
    wordPtrToPtr :: WordPtr -> Ptr a

foreign import ccall unsafe "__hscore_to_intptr"
    ptrToIntPtr :: Ptr a -> IntPtr

foreign import ccall unsafe "__hscore_from_intptr"
    intPtrToPtr :: IntPtr -> Ptr a



