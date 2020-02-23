//
//  AboutViewController.swift
//  YSQ
//
//  Created by Itay Garbash on 02/02/2020.
//  Copyright © 2020 Lazy Bear Apps. All rights reserved.
//

import UIKit

class AboutViewController: BetterUIViewController {

    @IBOutlet weak var aboutLabel: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        SettingsBundleHandler.shared.delegate = self
        SettingsBundleHandler.shared.setupNotificationObserver()
        
        
        aboutLabel.text = "\nSchema therapy was founded by Jeffrey Young and represents a development of cognitive behavioral therapy (CBT) specifically for treating personality disorders.\nEarly maladaptive schemata are described by Young as broad and pervasive themes or patterns made up of memories, feelings, sensations, and thoughts regarding oneself and one's relationships with others.\nThey are considered to develop during childhood or adolescence, and to be dysfunctional in that they lead to self-defeating behavior.\n\nExamples include schemata of abandonment/instability, mistrust/abuse, emotional deprivation, and defectiveness/shame.\nSchema therapy blends CBT with elements of Gestalt therapy, object relations, constructivist and psychoanalytic therapies in order to treat the characterological difficulties which both constitute personality disorders and which underlie many of the chronic depressive or anxiety-involving symptoms which present in the clinic.\n\nYoung said that CBT may be an effective treatment for presenting symptoms, but without the conceptual or clinical resources for tackling the underlying structures (maladaptive schemata) which consistently organize the patient's experience, the patient is likely to lapse back into unhelpful modes of relating to others and attempting to meet their needs.\n\nYoung focused on pulling from different therapies equally when developing schema therapy.\nThe difference between cognitive behavioral therapy and schema therapy is the latter \"emphasizes lifelong patterns, affective change techniques, and the therapeutic relationship, with special emphasis on limited reparenting\".\n\nHe recommended this therapy would be ideal for clients with difficult and chronic psychological disorders.\nSome examples would be eating disorders and personality disorders.\nHe has also had success with this therapy in relation to depression and substance abuse."
    }
    
    @IBAction func dismissPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}

/*"\nIn psychology and cognitive science, a schema (plural schemata or schemas) describes a pattern of thought or behavior that organizes categories of information and the relationships among them.\n\nIt can also be described as a mental structure of preconceived ideas, a framework representing some aspect of the world, or a system of organizing and perceiving new information.\n\nSchemata influence attention and the absorption of new knowledge: people are more likely to notice things that fit into their schema, while re-interpreting contradictions to the schema as exceptions or distorting them to fit.\nSchemata have a tendency to remain unchanged, even in the face of contradictory information.\nSchemata can help in understanding the world and the rapidly changing environment.\nPeople can organize new perceptions into schemata quickly as most situations do not require complex thought when using schema, since automatic thought is all that is required.\n\nPeople use schemata to organize current knowledge and provide a framework for future understanding.\n\nExamples of schemata include academic rubrics, social schemas, stereotypes, social roles, scripts, worldviews, and archetypes.\nIn Piaget's theory of development, children construct a series of schemata, based on the interactions they experience, to help them understand the world.\n\nSchema therapy was founded by Jeffrey Young and represents a development of cognitive behavioral therapy (CBT) specifically for treating personality disorders.[29][30] Early maladaptive schemata are described by Young as broad and pervasive themes or patterns made up of memories, feelings, sensations, and thoughts regarding oneself and one's relationships with others. They are considered to develop during childhood or adolescence, and to be dysfunctional in that they lead to self-defeating behavior. Examples include schemata of abandonment/instability, mistrust/abuse, emotional deprivation, and defectiveness/shame.\nSchema therapy blends CBT with elements of Gestalt therapy, object relations, constructivist and psychoanalytic therapies in order to treat the characterological difficulties which both constitute personality disorders and which underlie many of the chronic depressive or anxiety-involving symptoms which present in the clinic. Young said that CBT may be an effective treatment for presenting symptoms, but without the conceptual or clinical resources for tackling the underlying structures (maladaptive schemata) which consistently organize the patient's experience, the patient is likely to lapse back into unhelpful modes of relating to others and attempting to meet their needs. Young focused on pulling from different therapies equally when developing schema therapy. The difference between cognitive behavioral therapy and schema therapy is the latter \"emphasizes lifelong patterns, affective change techniques, and the therapeutic relationship, with special emphasis on limited reparenting\". He recommended this therapy would be ideal for clients with difficult and chronic psychological disorders. Some examples would be eating disorders and personality disorders. He has also had success with this therapy in relation to depression and substance abuse."*/
