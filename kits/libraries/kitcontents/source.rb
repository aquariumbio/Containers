# typed: false
# frozen_string_literal: true

needs 'Standard Libs/Units'

# A compilation of the components and volumes in kits.
# @author Cannon Mallory <malloc3@uw.edu>
module KitContents
  include Units

  #### Commonly used Consumables ######
  AREA_SEAL = "Microseal 'B' adhesive seals"
  MICRO_TUBE = '1.7 ml Tube'
  SPARE_PLATE = '96 Well Plate'
  TEST_TUBE = '15 ml Reagent Tube'
  TUBE_500UL = '0.5 ml Tube'

  #### Kit constants #####
  # Anneal RNA Kit
  EPH3_HT = 'EPH3 HT'

  # Synthesize First Strand cDNA Kit
  FSM_HT = 'First Strand Mix HT'
  RVT_HT = 'Reverse Transcriptase HT'

  # Amplify CDNA
  IPM_HT = 'Illumina PCR Mix HT'
  CPP1_HT = 'COVIDSeq Primer Pool 1 HT'
  CPP2_HT = 'COVIDSeq Primer Pool 2 HT'

  # Tagment PCR Aplicons
  EBLTS_HT = 'Enrichment BLT HT'
  TB1_HT = 'Tagmentation Buffer 1 HT'

  # Post Tagmentation Clean up
  ST2_HT = 'Stop Tagment Buffer 2 HT'
  TWB_HT = 'Tagmentation Wash Buffer HT'

  # Amplify Tagmented Amplicons
  EPM_HT = 'Enhanced PCR Mix HT'



  
  # Pool and Clean Up library
  ITB = 'Illumina Tune Beads'
  RSB_HT = 'Resuspension Buffer HT'

  # dsDNA HS Assay Kit
  COMP_A = 'HS Reagent, Component A'
  COMP_B = 'HS Buffer, Component B'
  COMP_C = 'HS Standard 1, Component C'
  COMP_D = 'HS Standard 2,Component D'
  QBIT_TUBE = 'Qubit Assay Tube'

  ##### Commonly used components ######
  ETOH = 'Absolute ethanol'
  WATER = 'Nuclease-free water'

  CONTENTS = {

    'Anneal RNA Kit' => {
      description: 'Kit for Anneal RNA',
      location: ['M20 Freezer'],
      components: [
        { input_name: EPH3_HT,
          qty: 8.5, units: MICROLITERS,
          object_type: "bottle"}
      ],
      consumables: []
    },

    'Synthesize First Strand cDNA Kit' => {
      description: 'Kit for Synthesize First Strand cDNA',
      location: ['M20 Freezer'],
      components: [
        { input_name: FSM_HT,
          qty: 9, units: MICROLITERS,
          sample_name: 'na',
          object_type: 'Reagent Bottle' },
        { input_name: RVT_HT,
          qty: 1, units: MICROLITERS,
          sample_name: 'na',
          object_type: 'Reagent Bottle' }
      ],
      consumables: [
        { input_name: MICRO_TUBE,
          qty: 1, units: 'Each',
          description: MICRO_TUBE }
      ]
    },

    'Amplify cDNA Kit' => {
      description: 'Kit for Amplify cDNA',
      location: ['M20 Freezer'],
      components: [
        { input_name: IPM_HT,
          qty: 12.5, units: MICROLITERS,
          sample_name: nil,
          object_type: 'Reagent Bottle' },
        { input_name: CPP1_HT,
          qty: 3.58, units: MICROLITERS,
          sample_name: nil,
          object_type: 'Reagent Bottle' },
        { input_name: CPP2_HT,
          qty: 3.58, units: MICROLITERS,
          sample_name: nil,
          object_type: 'Reagent Bottle' }
      ],
      consumables: []
    },

    'Tagment PCR Amplicons Kit' => {
      description: 'Kit for Tagment PCR Amplicons Kit',
      location: ['M20 Freezer'],
      components: [
        { input_name: EBLTS_HT,
          qty: 4, units: MICROLITERS,
          object_type: 'Reagent Bottle' },
        { input_name: TB1_HT,
          qty: 12, units: MICROLITERS,
          object_type: 'Reagent Bottle' }
      ],
      consumables: [
        { input_name: MICRO_TUBE,
          qty: 1, units: 'Each',
          description: MICRO_TUBE }
      ]
    },

    'Post Tagmentation Clean Up Kit' => {
      description: 'Kit for Post Tagmentation Clean Up Kit',
      location: ['M20 Freezer'],
      components: [ 
        { input_name: ST2_HT, 
          qty: 10, units: MICROLITERS, 
          object_type: 'Reagent Bottle' }, 
        { input_name: TWB_HT,
          qty: 100, units: MICROLITERS,
          object_type: 'Reagent Bottle' },
      ],
      consumables: []
    },

    'Amplify Tagmented Amplicons Kit' => {
      description: 'Kit for amplifying tagmented amplicons',
      location: ['M20 Freezer'],
      components: [
        {
          input_name: EPM_HT,
          qty: 24, units: MICROLITERS,
          object_type: 'Reagent Bottle'
        }
      ],
      consumables: []
    },

    'Library Pooling Kit' => {
      description: 'Kit for Library pooling and Cleanup',
      location: ['M20 Freezer'],
      components: [
        {
          input_name: ITB,
          qty: 55, units: MICROLITERS,
          sample_name: nil,
          object_type: 'Reagent Bottle',
          notes: 'Thaw and Keep on Ice'
        },
        {
          input_name: RSB_HT,
          qty: 10, units: MICROLITERS,
          sample_name: nil,
          object_type: 'Reagent Bottle',
          notes: 'Thaw and Keep on Ice'
        },
        {
          input_name: ETOH,
          qty: 1000, units: MICROLITERS,
          sample_name: nil,
          object_type: 'Reagent Bottle',
          notes: 'na'
        }
      ],
      consumables: []
    },

    'dsDNA HS Assay Kit' => {
      description: 'Qubit dsNDA HS Assay kit',
      location: ['M20 Freezer'],
      components: [
        {
          input_name: COMP_A,
          qty: 1, units: MICROLITERS,
          sample_name: nil,
          object_type: 'Reagent Bottle',
          notes: 'Bring to room temp'
        },
        {
          input_name: COMP_B,
          qty: 199, units: MICROLITERS,
          sample_name: nil,
          object_type: 'Reagent Bottle',
          notes: 'Bring to room temp'
        },
        {
          input_name: COMP_C,
          qty: 10, units: MICROLITERS,
          sample_name: nil,
          object_type: 'Reagent Bottle',
          notes: 'Bring to room temp'
        },
        {
          input_name: COMP_D,
          qty: 10, units: MICROLITERS,
          sample_name: nil,
          object_type: 'Reagent Bottle',
          notes: 'Bring to room temp'
        }
      ],
      consumables: [
        {
          input_name: QBIT_TUBE,
          qty: 3, units: 'Each',
          description: 'Thin-Wall, clear, 0.5-mL PCR Tubes'
        },
      ]
    }

  }.freeze
end
