MODULE GLOBAL_CONSTANTS
 
! Module containing global constants, parameters, variables
 
USE PRECISION_PARAMETERS
IMPLICIT NONE

CHARACTER(255), PARAMETER :: consid='$Id$'
CHARACTER(255), PARAMETER :: consrev='$Revision$'
CHARACTER(255), PARAMETER :: consdate='$Date$'

! Indices for various modes of operation

INTEGER, PARAMETER :: MIXTURE_FRACTION_SPECIES=1,GAS_SPECIES=2,AEROSOL_SPECIES=3            ! For SPECIES%MODE
INTEGER, PARAMETER :: MIXTURE_FRACTION_REACTION=1,FINITE_RATE_REACTION=2                    ! For REACTION%MODE
INTEGER, PARAMETER :: ADIABATIC_INDEX=0,INTERPOLATED_BC=6,SPECIFIED_TEMPERATURE=1, &
                      SPECIFIED_HEAT_FLUX=-1,THERMALLY_THICK=3, &
                      INFLOW_OUTFLOW=4,NO_CONVECTION=2                                      ! Heat transfer BC
INTEGER, PARAMETER :: EXPOSED=0,VOID=1,INSULATED=2                                          ! Surface backing
INTEGER, PARAMETER :: SURF_CARTESIAN=0,SURF_CYLINDRICAL=1,SURF_SPHERICAL=2                  ! Surface geometry
INTEGER, PARAMETER :: NO_MASS_FLUX=1,SPECIFIED_MASS_FRACTION=2,SPECIFIED_MASS_FLUX=3        ! Mass transfer BC
INTEGER, PARAMETER :: NULL_BOUNDARY=0,SOLID_BOUNDARY=1,OPEN_BOUNDARY=2,MIRROR_BOUNDARY=3, &
                      POROUS_BOUNDARY=4,VIRTUAL_BOUNDARY=5,INTERPOLATED_BOUNDARY=6          ! Boundary Type
INTEGER, PARAMETER :: FUEL_INDEX=1,O2_INDEX=2,N2_INDEX=3,H2O_INDEX=4,CO2_INDEX=5,CO_INDEX=6,H2_INDEX=7, &
                      SOOT_INDEX=8,OTHER_INDEX=9                                            ! Mixture Fraction Species
INTEGER, PARAMETER :: DIRICHLET=1,NEUMANN=2                                                 ! Pressure Boundary Conditions
INTEGER, PARAMETER :: PYROLYSIS_NONE=0,PYROLYSIS_SOLID=1,PYROLYSIS_LIQUID=2,&
                      PYROLYSIS_MATERIAL=3,PYROLYSIS_SPECIFIED=4                            ! Pyrolysis model
INTEGER, PARAMETER :: ATMOSPHERIC=1, PARABOLIC=2, ONED_PARABOLIC=3                          ! Surface velocity profile
INTEGER, PARAMETER :: CELL_CENTER=1, CELL_FACE=2, CELL_EDGE=3                               ! Cell position for output quantities
INTEGER, PARAMETER :: NO_STOP=0, INSTABILITY_STOP=1, USER_STOP=2, SETUP_STOP=3              ! Program Stop Status

! Program Status Code

INTEGER :: PROCESS_STOP_STATUS=NO_STOP

! Miscellaneous logical constants
 
LOGICAL :: LES,DNS,ISOTHERMAL,RADIATION, &
         CYLINDRICAL,NOISE,MIXTURE_FRACTION=.FALSE., &
         BAROCLINIC,PREDICTOR,CORRECTOR, &
         APPEND,DROPLET_FILE=.FALSE.,RESTART, &
         SUPPRESSION,CO_PRODUCTION,ACCUMULATE_WATER,WRITE_XYZ, &
         CHECK_POISSON,CHECK_VOLUME_FLOW=.FALSE.,TWO_D,SET_UP=.FALSE.,SMOKE3D, &
         STATUS_FILES,DEBUG,SYNCHRONIZE,TIMING,LOCK_TIME_STEP=.FALSE.,  &
         FLUSH_FILE_BUFFERS,PRESSURE_CORRECTION,RESTRICT_MESH_ASSIGNMENT=.TRUE., &
         COLUMN_DUMP_LIMIT,MASS_FILE,STATE_FILE,STRATIFICATION,SOLID_PHASE_ONLY, &
         AL2O3=.FALSE.,UL_PAN_DATA=.FALSE.,EDDY_BREAKUP=.FALSE.,SHARED_FILE_SYSTEM=.TRUE.
LOGICAL, ALLOCATABLE, DIMENSION(:) :: SYNC_TIME_STEP,CHANGE_TIME_STEP

! Miscellaneous character strings

CHARACTER(10) :: SMOKE3D_COMPRESSION
CHARACTER(256) :: TITLE,RENDER_FILE
CHARACTER(40) :: CHID,RESTART_CHID

! Dates, version numbers, revision numbers

CHARACTER(20) :: COMPILE_DATE='null',VERSION_STRING='null'
REAL(FB) :: VERSION_NUMBER=5.0
INTEGER :: SVN_REVISION_NUMBER=0
 
! Global EVACuation parameters

LOGICAL, ALLOCATABLE, DIMENSION(:) :: EVACUATION_ONLY, EVACUATION_GRID
REAL(EB) :: EVAC_DT_FLOWFIELD,EVAC_DT_STEADY_STATE,EVAC_DT,T_EVAC,T_EVAC_SAVE
INTEGER :: EVAC_PRESSURE_ITERATIONS,EVAC_TIME_ITERATIONS,EVAC_N_QUANTITIES,I_EVAC
INTEGER :: EVAC_AVATAR_NCOLOR
CHARACTER(30), ALLOCATABLE, DIMENSION(:) :: EVAC_CLASS_NAME
INTEGER, ALLOCATABLE, DIMENSION(:) :: EVAC_QUANTITIES_INDEX
INTEGER, ALLOCATABLE, DIMENSION(:,:) :: EVAC_CLASS_RGB,EVAC_AVATAR_RGB
REAL(EB), ALLOCATABLE, DIMENSION(:) :: EVACUATION_Z_OFFSET

! Miscellaneous real constants
 
REAL(EB) :: CPOPR,RSC,RPR,TMPA,TMPA4,TMPM,RHOA,P_INF,P_STP,GRAV,R0,R1, &
            CP_GAMMA,GAMMA,U0,V0,W0,H0,GVEC(3),CSMAG, &
            LAPSE_RATE,ONTH,THFO,ONSI,HCH,HCV,TEX_ORI(3), &
            SIGMA,TWTH,FOTH,KAPPA0,C_FORCED,H_FIXED,ASSUMED_GAS_TEMPERATURE, &
            CHARACTERISTIC_VELOCITY,CFL_MAX,CFL_MIN,VN_MAX,VN_MIN,  &
            PI,SQRTPI,RPI,RFPI,TWOPI,PIO2,PR,SC,C_P_W,H_V_W,SMOKE_ALBEDO,GROUND_LEVEL=0._EB

! Parameters associated with parallel mode

INTEGER :: MYID=0,NUMPROCS=1,EVAC_PROCESS=-1
LOGICAL :: PARALLEL=.FALSE.
INTEGER, ALLOCATABLE, DIMENSION(:) :: PROCESS

! Time parameters

REAL(EB) :: T_BEGIN,T_END,TIME_SHRINK_FACTOR,RELAXATION_FACTOR
 
! Combustion parameters
 
REAL(EB), PARAMETER :: MW_O2=32._EB,MW_H2=2._EB,MW_CO2=44._EB,MW_H2O=18._EB,MW_N2=28._EB,MW_CO=28._EB, &
                       MW_C=12._EB,MW_H=1._EB,MW_O=16._EB,MW_N=14._EB, &
                       !HEAT_OF_FORMATION kJ/mol Drysdale, Fire Dynamics
                       CO_HEAT_OF_FORMATION = 110.523E3_EB, CO2_HEAT_OF_FORMATION = 393.513E3_EB, &
                       H2O_HEAT_OF_FORMATION = 241.826E3_EB 
REAL(EB) :: MW_AIR,MW_SOOT,HRRPUA_SHEET,DIMENSION_SHEET,RHO_SOOT,VISIBILITY_FACTOR,MASS_EXTINCTION_COEFFICIENT,EC_LL
INTEGER :: N_SPECIES,N_SPEC_DILUENTS,I_WATER,I_CO2,N_REACTIONS,I_FUEL,I_PROG_CO, I_PROG_F, I_CO, I_O2,I_SOOT
REAL(EB) :: RSUM0
REAL(EB), DIMENSION(0:10) :: RCON_MF
REAL(EB), DIMENSION(0:10000) :: Z_2_MAX,MW_MF_CORR_O2,MW_MF_CORR_FUEL
REAL(EB), DIMENSION(0:10000,1:9) :: Y_CORR_O2,Y_CORR_FUEL
REAL(EB), ALLOCATABLE, DIMENSION(:,:) :: Z2Y,Z2MW,Z2CP,Z2D,Z2K,Z2MU
REAL(EB), ALLOCATABLE, DIMENSION(:) :: Z2Y_C,Z2MW_C,Z2CP_C,Z2D_C,Z2K_C,Z2MU_C,MW_AVG_Z,Y_MF_SUM_Z
REAL(EB) :: MW_AVG_C,Y_MF_SUM_C

! Ramping parameters
 
CHARACTER(30) :: RAMP_ID(1000),RAMP_TYPE(1000)
INTEGER :: I_RAMP_GX,I_RAMP_GY,I_RAMP_GZ,N_RAMP
INTEGER, PARAMETER :: TIME_HEAT=-1,TIME_VELO=-2,TIME_TEMP=-3,TANH_RAMP=-2,TSQR_RAMP=-1

! TABLe parameters

CHARACTER(30) :: TABLE_ID(1000)
INTEGER :: N_TABLE=0,TABLE_TYPE(1000)
INTEGER, PARAMETER :: SPRAY_PATTERN=1

! Variables related to meshes

INTEGER :: NMESHES=1
CHARACTER(30), DIMENSION(:), ALLOCATABLE :: MESH_NAME
INTEGER, DIMENSION(:,:), ALLOCATABLE ::  I_MIN,I_MAX,J_MIN,J_MAX,K_MIN,K_MAX,NIC

! Miscellaneous integer constants
 
INTEGER :: ICYC,WALL_INCREMENT,NFRAMES,NCGC
INTEGER, ALLOCATABLE, DIMENSION(:,:) :: PBC
 
! Clocks for output file dumps
 
REAL(EB), ALLOCATABLE, DIMENSION(:) :: PART_CLOCK,CORE_CLOCK,SLCF_CLOCK, &
                                       PL3D_CLOCK,BNDF_CLOCK,ISOF_CLOCK,PROF_CLOCK
REAL(EB) :: MINT_CLOCK,DEVC_CLOCK,HRR_CLOCK,EVAC_CLOCK,CTRL_CLOCK
REAL(EB) :: DT_SLCF,DT_BNDF,DT_DEVC,DT_PL3D,DT_PART,DT_RESTART,DT_ISOF,DT_HRR,DT_MASS,DT_PROF,DT_CTRL

! Coarse mesh spacings

REAL(EB), ALLOCATABLE, DIMENSION(:,:) :: DX_M,DY_M,DZ_M
 
! Logical units and output file names
 
INTEGER                              :: LU_INPUT=55
INTEGER                              :: LU_MASS,LU_HRR,LU_OUTPUT,LU_SMV,LU_END,LU_ERR=0,LU_NOTREADY
INTEGER                              :: LU_EVACCSV,LU_EVACEFF,LU_EVACFED,LU_EVACOUT
INTEGER, ALLOCATABLE, DIMENSION(:)   :: LU_PART,LU_PROF,LU_XYZ,LU_PL3D,LU_DEVC,LU_STATE,LU_CTRL,LU_CORE,LU_RESTART
INTEGER, ALLOCATABLE, DIMENSION(:,:) :: LU_SLCF,LU_BNDF,LU_ISOF,LU_SMOKE3D

CHARACTER(250)                             :: FN_INPUT='null'
CHARACTER(80)                              :: FN_MASS,FN_HRR,FN_OUTPUT,FN_SMV,FN_END,FN_ERR,FN_NOTREADY
CHARACTER(80)                              :: FN_EVACCSV,FN_EVACEFF,FN_EVACFED,FN_EVACOUT
CHARACTER(80), ALLOCATABLE, DIMENSION(:)   :: FN_PART,FN_PROF,FN_XYZ,FN_PL3D,FN_DEVC,FN_STATE,FN_CTRL,FN_CORE,FN_RESTART
CHARACTER(80), ALLOCATABLE, DIMENSION(:,:) :: FN_SLCF,FN_BNDF,FN_ISOF,FN_SMOKE3D
 
! Boundary condition arrays
 
CHARACTER(30) :: SURF_NAME(0:1000),MATL_NAME(1:1000)
INTEGER :: N_SURF,N_MATL,MIRROR_SURF_INDEX,OPEN_SURF_INDEX,INTERPOLATED_SURF_INDEX,DEFAULT_SURF_INDEX=0,INERT_SURF_INDEX=0
REAL(EB), ALLOCATABLE, DIMENSION(:) :: AAS,BBS,CCS,DDS,DDT,DX_S,RDX_S,RDXN_S,DX_WGT_S, &
                                       K_S,RHOCBAR,C_S,RHO_S,Q_S,KAPPA_S,X_S_NEW
INTEGER,  ALLOCATABLE, DIMENSION(:) :: LAYER_INDEX

! Divergence Arrays

REAL(EB), ALLOCATABLE, DIMENSION(:,:) :: DSUM,USUM,PSUM

! Raised vegetation arrays
 
INTEGER :: N_TREES
REAL(EB), ALLOCATABLE, DIMENSION(:) :: CANOPY_W,CANOPY_B_H, TREE_H,X_TREE,Y_TREE,Z_TREE
INTEGER, ALLOCATABLE, DIMENSION(:) :: TREE_PARTICLE_CLASS
!rm ->
LOGICAL, ALLOCATABLE, DIMENSION(:) :: TREE_MESH
LOGICAL :: TREE
!rm <-
 
! Sprinkler Variables
 
REAL(EB) :: C_DIMARZO=6.E6_EB
INTEGER :: NSTRATA
INTEGER, PARAMETER :: NDC=1000
LOGICAL :: POROUS_FLOOR

! Particles and Droplets
 
INTEGER :: MAXIMUM_DROPLETS,N_PART,PARTICLE_TAG,N_EVAC,N_EVAP_INDICIES=0
 
! Initial value and pressure zone arrays
 
INTEGER :: N_INIT,N_ZONE
 
! Output quantity arrays
 
INTEGER, PARAMETER :: N_OUTPUT_QUANTITIES=280
INTEGER :: PLOT3D_QUANTITY_INDEX(5),SMOKE3D_QUANTITY_INDEX,SMOKE3D_SPECIES_INDEX
CHARACTER(30) :: PLOT3D_QUANTITY(5),SMOKE3D_QUANTITY
INTEGER :: N_BNDF,N_ISOF,N_PROF,N_SLCF_MAX=0
REAL(EB),ALLOCATABLE, DIMENSION(:) :: HRR,RHRR,CHRR,FHRR,FUEL_DROPLET_MLR,MLR,HRR_SUM,RHRR_SUM,CHRR_SUM,FHRR_SUM,MLR_SUM,HRR_COUNT
REAL(EB),ALLOCATABLE, DIMENSION(:,:) :: MINT,MINT_SUM
REAL(EB),ALLOCATABLE, DIMENSION(:) :: MINT_COUNT

! Clipping values
 
REAL(EB) :: TMPMIN,TMPMAX,YYMIN(MAX_SPECIES),YYMAX(MAX_SPECIES),RHOMIN,RHOMAX
 
! CPU and Wall Clock Timings
 
INTEGER, PARAMETER :: N_TIMERS_FDS=11,N_TIMERS_EVAC=15,N_TIMERS_DIM=20
REAL(EB), ALLOCATABLE, DIMENSION(:,:) :: TUSED
INTEGER, ALLOCATABLE, DIMENSION(:) :: NTCYC,NCYC
REAL(EB), ALLOCATABLE, DIMENSION(:) :: T_PER_STEP,T_ACCUM
REAL(EB) :: WALL_CLOCK_START, WALL_CLOCK_END, WALL_CLOCK_START_ITERATIONS

CONTAINS

SUBROUTINE GET_REV_cons(MODULE_REV,MODULE_DATE)
INTEGER,INTENT(INOUT) :: MODULE_REV
CHARACTER(255),INTENT(INOUT) :: MODULE_DATE

WRITE(MODULE_DATE,'(A)') consrev(INDEX(consrev,':')+1:LEN_TRIM(consrev)-2)
READ (MODULE_DATE,'(I5)') MODULE_REV
WRITE(MODULE_DATE,'(A)') consdate

END SUBROUTINE GET_REV_cons
 
END MODULE GLOBAL_CONSTANTS
