//
//  QuestionModel.swift
//  YSQ
//
//  Created by Itay Garbash on 01/02/2020.
//  Copyright © 2020 Lazy Bear Apps. All rights reserved.
//

import Foundation

public class QuestionModel {
    
    var currentQuestion = 0
    public static let shared = QuestionModel()

    public var questions: [String] = []
    
    public let short = [
        "I haven’t had someone to nurture me, share him/herself with me, or care deeply about everything that happens to me.",
        "I find myself clinging to people I’m close to because I’m afraid they’ll leave me.",
        "I feel that people will take advantage of me.",
        "I don’t fit in.",
        "No man/woman I desire could love me once he or she saw my defects or flaws.",
        "Almost nothing I do at work (or school) is as good as other people can do.",
        "I do not feel capable of getting by on my own in everyday life.",
        "I can’t seem to escape the feeling that something bad is about to happen.",
        "I have not been able to separate myself from my parent(s) the way other people my age seem to.",
        "I think that if I do what I want, I’m only asking for trouble.",
        "I’m the one who usually ends up taking care of the people I’m close to.",
        "I am too self-conscious to show positive feelings to others (e.g., affection, showing I care).",
        "I must be the best at most of what I do; I can’t accept second best.",
        "I have a lot of trouble accepting “no” for an answer when I want something from other people.",
        "I can’t seem to discipline myself to complete most routine or boring tasks.",
        "Having money and knowing important people make me feel worthwhile.",
        "Even when things seem to be going well, I feel that it is only temporary.",
        "If I make a mistake, I deserve to be punished"
     ]
    
    public let long = [
        
        "I haven’t had someone to nurture me, share him/herself with me, or care deeply about everything that happens to me.",
        "I find myself clinging to people I’m close to because I’m afraid they’ll leave me.",
        "I feel that people will take advantage of me.",
        "I don’t fit in.",
        "No man/woman I desire could love me once he or she saw my defects or flaws.",
        "Almost nothing I do at work (or school) is as good as other people can do.",
        "I do not feel capable of getting by on my own in everyday life.",
        "I can’t seem to escape the feeling that something bad is about to happen.",
        "I have not been able to separate myself from my parent(s) the way other people my age seem to.",
        "I think that if I do what I want, I’m only asking for trouble.",
        "I’m the one who usually ends up taking care of the people I’m close to.",
        "I am too self-conscious to show positive feelings to others (e.g., affection, showing I care).",
        "I must be the best at most of what I do; I can’t accept second best.",
        "I have a lot of trouble accepting “no” for an answer when I want something from other people.",
        "I can’t seem to discipline myself to complete most routine or boring tasks.",
        "Having money and knowing important people make me feel worthwhile.",
        "Even when things seem to be going well, I feel that it is only temporary.",
        "If I make a mistake, I deserve to be punished",
        "I don’t have people to give me warmth, holding, and affection.",
        "I need other people so much that I worry about losing them.",
        "I feel that I cannot let my guard down in the presence of other people, or else they will intentionally hurt me.",
        "I’m fundamentally different from other people.",
        "No one I desire would want to stay close to me if he or she knew the real me.",
        "I’m incompetent when it comes to achievement.",
        "I think of myself as a dependent person when it comes to everyday functioning.",
        "I feel that a disaster (natural, criminal, financial, or medical) could strike at any moment.",
        "My parent(s) and I tend to be over-involved in each other’s lives and problems.",
        "I feel as if I have no choice but to give in to other people’s wishes, or else they will retaliate, get angry, or reject me in some way.",
        "I am a good person because I think of others more than myself.",
        "I find it embarrassing to express my feelings to others.",
        "I try to do my best; I can’t settle for “good enough.”",
        "I’m special and shouldn’t have to accept many of the restrictions or limitations placed on other people.",
        "If I can’t reach a goal, I become easily frustrated and give up.",
        "Accomplishments are most valuable to me if other people notice them.",
        "If something good happens, I worry that something bad is likely to follow.",
        "If I don't try my hardest, I should expect to lose out.",
        "I have never felt that I'm special to someone.",
        "I worry that people I feel close to will leave me or abandon me.",
        "It is only a matter of time before someone betrays me.",
        "I don’t belong; I’m a loner.",
        "I’m unworthy of the love, attention, and respect of others.",
        "Most other people are more capable than I am in areas of work and achievement.",
        "I lack common sense.",
        "I worry about being physically attacked by people.",
        "It is very difficult for my parent(s) and me to keep intimate details from each other without feeling betrayed or guilty.",
        "In relationships, I usually let the other person have the upper hand.",
        "I’m so busy doing things for the people that I care about that I have little time for myself.",
        "I find it hard to be free-spirited and spontaneous around other people.",
        "I must meet all my responsibilities.",
        "I hate to be constrained or kept from doing what I want.",
        "I have a very difficult time sacrificing immediate gratification or pleasure to achieve a long- range goal.",
        "Unless I get a lot of attention from others, I feel less important.",
        "You can’t be too careful; something will almost always go wrong.",
        "If I don’t do the job right, I should suffer the consequences.",
        "I have not had someone who really listens to me, understands me, or is tuned into my true needs and feelings.",
        "When someone I care for seems to be pulling away or withdrawing from me, I feel desperate.",
        "I am quite suspicious of other people’s motives.",
        "I feel alienated or cut off from other people.",
        "I feel that I’m not lovable.",
        "I’m not as talented as most people are at their work.",
        "My judgment cannot be counted on in everyday situations.",
        "I worry that I’ll lose all my money and become destitute or very poor.",
        "I often feel as if my parent(s) are living through me – that I don’t have a life of my own.",
        "I’ve always let others make choices for me, so I really don’t know what I want for myself.",
        "I’ve always been the one who listens to everyone else’s problems.",
        "I control myself so much that many people think I am unemotional or unfeeling.",
        "I feel that there is constant pressure for me to achieve and get things done.",
        "I feel that I shouldn’t have to follow the normal rules or conventions that other people do.",
        "I can’t force myself to do things I don’t enjoy, even when I know it’s for my own good.",
        "If I make remarks at a meeting, or am introduced in a social situation, it’s important for me to get recognition and admiration.",
        "No matter how hard I work, I worry that I could be wiped out financially and lose almost everything.",
        "It doesn’t matter why I make a mistake. When I do something wrong, I should pay the consequences.",
        "I haven’t had a strong or wise person to give me sound advice or direction when I’m not sure what to do.",
        "Sometimes I am so worried about people leaving me that I drive them away.",
        "I’m usually on the lookout for people’s ulterior or hidden motives.",
        "I always feel on the outside of groups.",
        "I am too unacceptable in very basic ways to reveal myself to other people or to let them get to know me well.",
        "I’m not as intelligent as most people when it comes to work (or school).",
        "I don’t feel confident about my ability to solve everyday problems that come up.",
        "I worry that I’m developing a serious illness, even though nothing serious has been diagnosed by a doctor.",
        "I often feel I do not have a separate identity from my parent(s) or partner.",
        "I have a lot of trouble demanding that my rights be respected and that my feelings be taken into account.",
        "Other people see me as doing too much for others and not enough for myself.",
        "People see me as uptight emotionally.",
        "I can’t let myself off the hook easily or make excuses for my mistakes.",
        "I feel that what I have to offer is of greater value than the contributions of others.",
        "I have rarely been able to stick to my resolutions.",
        "Lots of praise and compliments make me feel like a worthwhile person.",
        "I worry that a wrong decision could lead to disaster.",
        "I’m a bad person who deserves to be punished."
    ]
    
}
