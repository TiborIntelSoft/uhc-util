{-# LANGUAGE CPP #-}

-- wrapping around different versions of directory, enforcing different time packages to be used.

#define DIRECTORY_USES_UTCTIME 1

module UHC.Util.Time
  (
        module Data.Time.Compat,
#	ifdef DIRECTORY_USES_UTCTIME
		module Data.Time,
		module Data.Time.Clock,
		ClockTime,
		diffClockTimes,
		noTimeDiff,
		getClockTime
#	else
		module System.Time
#	endif
  )
  where

#ifdef DIRECTORY_USES_UTCTIME
import Data.Time
import Data.Time.Clock
#else
import System.Time
#endif
import Data.Time.Compat

#ifdef DIRECTORY_USES_UTCTIME
-- | a for now alias for old-time ClockTime
type ClockTime = UTCTime

diffClockTimes = diffUTCTime

noTimeDiff :: NominalDiffTime
noTimeDiff = toEnum 0

getClockTime :: IO ClockTime
getClockTime = getCurrentTime
#endif
